RSpec.describe User do
  let(:user) { build(:user, name: name) }

  context "when name is valid" do
    let(:name) { "John" }

    it "is valid with a name of 3 or more characters" do
      expect(user).to be_valid
    end
  end

  context "when name is not present" do
    let(:name) { nil }

    it "is invalid without a name" do
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  context "when name is too short" do
    let(:name) { "Jo" }

    it "is invalid with a name shorter than 3 characters" do
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("must be at least 3 characters long")
    end
  end
end
