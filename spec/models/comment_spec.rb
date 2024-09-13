RSpec.describe Comment do
  subject(:comment) { build(:comment) }

  before do
    allow(comment).to receive(:broadcast_prepend_to)
  end

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end


  context "when content is blank" do
    let(:blank_content_comment) { build(:comment, content: "") }

    it "is not valid without content" do
      expect(blank_content_comment).not_to be_valid
      expect(blank_content_comment.errors[:content]).to include("can't be blank")
    end
  end

  context "when content is too long" do
    let(:long_content_comment) { build(:comment, content: "a" * 501) }

    it "is not valid with content longer than 500 characters" do
      expect(long_content_comment).not_to be_valid
      expect(long_content_comment.errors[:content]).to include("is too long (maximum is 500 characters)")
    end
  end

  context "when content is whitespace only" do
    let(:whitespace_comment) { build(:comment, content: "   ") }

    it "is not valid with whitespace-only content" do
      expect(whitespace_comment).not_to be_valid
      expect(whitespace_comment.errors[:content]).to include("must contain non-whitespace characters")
    end
  end
end
