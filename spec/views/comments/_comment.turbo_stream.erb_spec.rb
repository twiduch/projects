RSpec.describe "comments/_comment.turbo_stream", type: :view do
  let(:user) { create(:user, name: "Test User") }
  let(:project) { create(:project, status: "planned") }
  let(:comment) {
 create(:comment, user: user, project: project, content: "This is a test comment", created_at: Time.new(2023, 1, 1, 12, 0, 0)) }

  before do
    render partial: "comments/comment", locals: { comment: comment }, formats: [ :turbo_stream ]
  end

  it "renders a div with the correct id and class" do
    expect(rendered).to include(%(div id="added_#{dom_id(comment)}"))
    expect(rendered).to include(%(class="fade-in"))
  end

  it "renders the comment partial with the correct content" do
    expect(rendered).to include("<strong class=\"text-bold font-medium\">Author:</strong>")
    expect(rendered).to include("Test User")
    expect(rendered).to include("This is a test comment")
    expect(rendered).to include("January 01, 2023 at 12:00 PM")
  end

  it "includes JavaScript for the fade-in effect" do
    expect(rendered).to include("setTimeout(() => {")
    expect(rendered).to include("document.getElementById(\"added_#{dom_id(comment)}\").classList.add('fade-in-enter');")
  end

  it "includes the correct Stimulus controller update script" do
    expect(rendered).to include("getControllerForElementAndIdentifier(document.getElementById('project_status'), 'status-select')")
  end
end
