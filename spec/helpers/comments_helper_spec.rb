RSpec.describe CommentsHelper, type: :helper do
  let(:user) { build(:user) }
  let(:comment_with_author) { build(:comment, user: user) }
  let(:comment_without_author) { build(:comment, user: nil) }

  describe "#comment_author" do
    context "when the comment has an associated user" do
      it "returns the user's name" do
        expect(helper.comment_author(comment_with_author)).to eq(user.name)
      end
    end

    context "when the comment does not have an associated user" do
      it "returns 'Unknown Author'" do
        expect(helper.comment_author(comment_without_author)).to eq("Unknown Author")
      end
    end
  end
end
