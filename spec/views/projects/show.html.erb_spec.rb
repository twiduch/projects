require 'rails_helper'

RSpec.describe "projects/show.html.erb", type: :view do
  let(:user) { create(:user, name: "Test User") }
  let(:project) { create(:project) }
  let(:comment1) { create(:comment, project: project, user: user, content: "First comment") }
  let(:comment2) { create(:comment, project: project, user: user, content: "Second comment") }

  before do
    assign(:project, project)
    assign(:comments, [ comment1, comment2 ])
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it "displays the project name" do
    expect(rendered).to include(project.name)
  end

  it "displays the status selector with the correct options" do
    expect(rendered).to include("planned")
    expect(rendered).to include("started")
    expect(rendered).to include("paused")
    expect(rendered).to include("review")
    expect(rendered).to include("completed")
    expect(rendered).to include("canceled")
  end

  it "renders the comments list" do
    expect(rendered).to include("First comment")
    expect(rendered).to include("Second comment")
  end

  it "displays the status change message element" do
    expect(rendered).to include('<span id="status-message"')
  end
end
