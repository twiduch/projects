RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:valid_attributes) { { comment: { content: "This is a valid comment." }, project_id: project.id } }
  let(:invalid_attributes) { { comment: { content: "" }, project_id: project.id } }

  before do
    project.users << user
    sign_in user
  end

  describe "POST /comments" do
    context "with valid parameters" do
      it "creates a new Comment and responds with status created" do
        expect {
          post comments_path, params: valid_attributes
        }.to change(Comment, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment and redirects with an alert" do
        expect {
          post comments_path, params: invalid_attributes
        }.to_not change(Comment, :count)

        expect(response).to redirect_to(project_path(project))
        expect(flash[:alert]).to eq("Comment could not be saved.")
      end
    end
  end
end
