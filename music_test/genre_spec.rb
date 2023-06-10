require_relative '../genre'
require_relative '../music'

describe Genre do
  describe '#initialize' do
    it 'should create a new genre' do
      genre = Genre.new('Pop')
      expect(genre.name).to eq 'Pop'
    end
  end
  describe '#add_item' do
    it 'should add an item to the genre' do
      genre = Genre.new('Pop')
      music_album = MusicAlbum.new('2020-01-01', false, true)
      genre.add_item(music_album)
      puts genre.items.length
      expect(genre.items.length).to eq 1
    end
  end
end
