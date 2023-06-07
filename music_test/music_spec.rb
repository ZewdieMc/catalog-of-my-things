require_relative '../music'

describe MusicAlbum do
  describe '#initialize' do
    it 'should create a new music album' do
      music_album = MusicAlbum.new('2020-01-01', false, true)
      expect(music_album.archived).to eq false
    end
  end
  describe '#can_be_archived?' do
    it 'should return true if the music album can be archived' do
      music_album = MusicAlbum.new('2020-01-01', false, true)
      expect(music_album.can_be_archived?).to eq false
    end
  end
end
