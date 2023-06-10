require './author'
require './game'
require './item'

describe Author do
  subject { described_class.new('Cal', 'Newport') }
  describe '#add_item' do
    it 'should add an item to the items array' do
      game = Game.new(Date.new(2000, 1, 1), false, Date.new(2018, 1, 1))
      subject.add_item(game)
      expect(subject.items).to include(game)
      expect(game.author).to eq(subject)
      expect(game.author.first_name).to eq('Cal')
    end
  end
end
