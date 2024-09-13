RSpec.describe "projects/index.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:project1) { create(:project, status: "planned") }
  let(:project2) { create(:project, status: "completed") }

  before do
    assign(:projects, [project1, project2])
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it "displays the user's name in the heading" do
    expect(rendered).to include("#{user.name}'s Projects")
  end

  it "renders the project names" do
    expect(rendered).to include(project1.name)
    expect(rendered).to include(project2.name)
  end

  it "displays the projects in a grid layout" do
    expect(rendered).to match(/<div id="groups" class="mt-5 min-w-full md:grid md:grid-cols-2 md:justify-items-center">.*<\/div>/m)
  end
end
