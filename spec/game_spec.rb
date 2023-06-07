require './game'

describe Game do
  subject { described_class.new(Date.new(2000, 1, 1), false, true, Date.new(2018, 1, 1)) }
  describe '#move_to_archive' do
    it 'should archive the game' do
      subject.move_to_archive
      expect(subject.archived).to eq(true)
    end
    it 'should not archive the game if it is not old enough' do
      subject.last_played_at = Date.today
      subject.move_to_archive
      expect(subject.archived).to eq(false)
    end
  end
end
