RSpec.describe Project do
  subject(:project) { build(:project) }

  it 'is valid with valid attributes' do
    expect(project).to be_valid
  end

  context 'when wrong status' do
    let(:project) { build(:project, status: :invalid) }

    it 'is invalid with wrong status' do
      expect(project).not_to be_valid
    end
  end
end
