RSpec.describe "Projects", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  describe "GET /projects" do
    before do
      project.users << user
      sign_in user
      get projects_path
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the list of projects" do
      expect(response.body).to include(project.name)
    end
  end

  describe "GET /projects/:id" do
    before do
      project.users << user
      sign_in user
    end

    context "when project is found" do
      before do
        get project_path(project)
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the project details" do
        expect(response.body).to include(project.name)
      end
    end

    context "when project is not found" do
      before do
        get project_path(id: 'nonexistent_id')
      end

      it "redirects to projects index with an alert" do
        expect(response).to redirect_to(projects_path)
        expect(flash[:alert]).to eq("We couldn't find this project. Let's see all of them.")
      end
    end
  end

  describe "POST /projects/:id/status_change" do
    let(:new_status) { "completed" }

    context "when status update is successful" do
      before do
        project.users << user
        sign_in user
        post status_change_project_path(project, status: new_status)
      end

      it "returns no content" do
        expect(response).to have_http_status(:no_content)
      end

      it "creates a status change comment" do
        expect(Comment.last.content).to eq("Project Status changed to #{new_status}")
      end
    end

    context "when status update fails" do
      before do
        allow_any_instance_of(Project).to receive(:update).and_return(false)
        project.users << user
        sign_in user
        post status_change_project_path(project, status: new_status), headers: headers
      end

      it "returns an internal server error" do
        expect(response).to have_http_status(:internal_server_error)
      end

      it "does not create a status change comment" do
        expect(Comment.count).to eq(0)
      end
    end
  end
end
