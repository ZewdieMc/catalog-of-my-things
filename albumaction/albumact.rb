require 'json'
require_relative '../music'

class Albumaction
  def getmusicalbum
    file_path = './album_data/music.json'
    if File.exist?(file_path)
      file_content = File.read(file_path)
      JSON.parse(file_content)
      if File.empty?(file_path)
        puts 'Empty album'
      else
        file_content = File.read(file_path)
        music_data = JSON.parse(file_content)
        music_data.each do |album|
          puts "Published date: #{album['publish_date']} - archived: #{album['archived']}
          - on spotify : #{album['on_spotify']}"
        end
      end
    else
      puts 'No album available'
    end
  end

  def getgenre
    file_path = './album_data/music.json'
    if File.exist?(file_path)
      file_content = File.read(file_path)
      JSON.parse(file_content)
      if File.empty?(file_path)
        puts 'Empty genre'
      else
        file_content = File.read(file_path)
        music_data = JSON.parse(file_content)
        music_data.each do |genre|
          puts genre['genre']
        end
      end
    else
      puts 'No genre available'
    end
  end

  # rubocop:disable Metrics/MethodLength
  def addmusicalbum
    file_path = './album_data/music.json'
    puts 'Enter Genre name'
    genre = gets.chomp
    puts 'Enter the publish date of the music album'
    publish_date = gets.chomp
    puts 'Is the music album archived? (true/false)'
    archived = gets.chomp
    puts 'Is the music album on spotify? (true/false)'
    on_spotify = gets.chomp
    music_hash = {
      genre: genre,
      publish_date: publish_date,
      archived: archived,
      on_spotify: on_spotify
    }
    music_data = []
    if File.exist?(file_path)
      if File.empty?(file_path)
        File.write(file_path, JSON.generate(music_data))
        file_content = File.read(file_path)
        music_data_file = JSON.parse(file_content)
        music_data_file << music_hash
        File.write(file_path, JSON.generate(music_data))
      else
        file_content = File.read(file_path)
        music_data_file = JSON.parse(file_content)
        music_data_file << music_hash
        File.write(file_path, JSON.generate(music_data_file))
      end
    else
      File.write(file_path, JSON.generate(music_data))
      file_content = File.read(file_path)
      music_data = JSON.parse(file_content)
      music_data << music_hash
      puts music_data
      File.write(file_path, JSON.generate(music_data))
    end
    puts 'data added successfully'
  end
  # rubocop:enable Metrics/MethodLength
end
