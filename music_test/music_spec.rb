require_relative '../music'

describe MusicAlbum do
  describe '#initialize' do
    it 'should create a new music album' do
      music_album = MusicAlbum.new('2020-01-01', false, true)
      expect(music_album.archived).to eq false
    end
  end
end
