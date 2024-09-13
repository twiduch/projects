RSpec.describe CreateStatusChangeComment do
  subject(:command) { described_class.new(project: project, user: user, status: status) }

  let(:project) { create(:project) }
  let(:user) { create(:user) }
  let(:status) { 'completed' }

  before do
    allow(Rails.logger).to receive(:error)
  end

  describe '#call' do
    context 'when the comment creation is successful' do
      it 'creates a new comment' do
        expect { command.call }.to change { Comment.count }.by(1)
      end

      it 'associates the comment with the correct project' do
        command.call
        expect(Comment.last.project).to eq(project)
      end

      it 'associates the comment with the correct user' do
        command.call
        expect(Comment.last.user).to eq(user)
      end

      it 'includes the correct status in the comment content' do
        command.call
        expect(Comment.last.content).to eq("Project Status changed to #{status}")
      end
    end

    context 'when the comment creation fails' do
      before do
        allow(Comment).to receive(:create!).and_raise(StandardError.new('Database error'))
      end

      it 'returns false' do
        expect(command.call).to be_falsey
      end

      it 'logs an error message' do
        command.call
        expect(Rails.logger).to have_received(:error).with(/Failed to create comment: Database error/)
      end
    end
  end
end
