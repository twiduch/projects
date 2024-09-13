RSpec.describe "comments/_comment", type: :view do
  let(:user) { create(:user, name: "Test User") }
  let(:comment) { create(:comment, user: user, content: "This is a test comment", created_at: Time.new(2023, 1, 1, 12, 0, 0)) }

  before do
    render partial: "comments/comment", locals: { comment: comment }
  end

  it "renders the author name correctly" do
    expect(rendered).to include("<strong class=\"text-bold font-medium\">Author:</strong>")
    expect(rendered).to include("Test User")
  end

  it "renders the comment content correctly" do
    expect(rendered).to include("This is a test comment")
  end

  it "renders the creation date correctly" do
    expect(rendered).to include("Created:")
    expect(rendered).to include("January 01, 2023 at 12:00 PM")
  end

  it "renders the correct DOM ID" do
    expect(rendered).to include(%(id="#{dom_id(comment)}"))
  end

  it "applies the correct CSS classes" do
    expect(rendered).to include("block relative my-5 break-after-column p-6 border border-gray-200 rounded-lg shadow hover:bg-gray-100")
  end
end
