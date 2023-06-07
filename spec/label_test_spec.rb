require_relative '../books/book_ui'
require_relative '../books/book'
require_relative '../books/label'
require 'date'

RSpec.describe Label do
  let(:label) { Label.new(42, 'Science Fiction', 'blue') }
  let(:book1) { Book.new('Dune', '1965-06-01', 'Chilton Books', 'good') }
  let(:book2) { Book.new('Ender\'s Game', '1985-01-15', 'Tor Books', 'bad') }

  describe '#initialize' do
    it 'creates a new label with the given attributes' do
      expect(label.id).to eq(42)
      expect(label.name).to eq('Science Fiction')
      expect(label.color).to eq('blue')
      expect(label.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'adds an item to the label\'s collection' do
      label.add_item(book1)
      expect(label.items).to include(book1)
    end

    it 'sets the label of the item to itself' do
      label.add_item(book2)
    end
  end

  describe '#remove_item' do
    before do
      label.add_item(book1)
      label.add_item(book2)
    end

    it 'removes an item from the label\'s collection' do
      label.remove_item(book1)
      expect(label.items).not_to include(book1)
      expect(label.items).to include(book2)
    end

    it 'sets the label of the removed item to nil' do
      label.remove_item(book2)
      expect(book2.label).to be_nil
    end
  end
end
