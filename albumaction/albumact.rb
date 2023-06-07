require 'json'
require_relative '../music.rb'

class Albumaction
    def get_music_album
        file_path = './album_data/music.json'
        if File.exist?(file_path)
            file_content = File.read(file_path)
            music_data = JSON.parse(file_content)
            if File.zero?(file_path)
                puts "Empty album"
            else
                file_content = File.read(file_path)
                music_data = JSON.parse(file_content)
                music_data.each do |album|
                    puts "Published date: #{album['publish_date']} ---- archived: #{album['archived']} ----- on spotify : #{album['on_spotify']}"
                  end
            end
        else
            puts "No album available"
        end
    end
    def get_genre
        file_path = './album_data/genre.json'
        if File.exist?(file_path)
            file_content = File.read(file_path)
            music_data = JSON.parse(file_content)
            if File.zero?(file_path)
                puts "Empty genre"
            else
                file_content = File.read(file_path)
                music_data = JSON.parse(file_content)
                music_data.each do |genre|
                    puts genre
                  end
            end
        else
            puts "No genre available"
        end
    end
    def add_music_album
        file_path = './album_data/music.json'
        puts "Enter the publish date of the music album"
        publish_date = gets.chomp
        puts "Is the music album archived? (true/false)"
        archived = gets.chomp
        puts "Is the music album on spotify? (true/false)"
        on_spotify = gets.chomp
        # music_album = MusicAlbum.new(publish_date, archived, on_spotify)
        music_hash = {
            publish_date: publish_date,
            archived: archived,
            on_spotify: on_spotify
          }
        music_data = []
        if File.exist?(file_path)
            if File.zero?(file_path)
                File.open(file_path, 'w') { |file| file.write(JSON.generate(music_data)) }
                file_content = File.read(file_path)
                music_data_file = JSON.parse(file_content)
                music_data_file << music_hash
                File.write(file_path, JSON.generate(music_data))
                puts "data added successfully"
            else
                file_content = File.read(file_path)
                music_data_file = JSON.parse(file_content)
                music_data_file << music_hash
                File.write(file_path, JSON.generate(music_data_file))
                puts "data added successfully"
            end
        else
            File.open(file_path, 'w') { |file| file.write(JSON.generate(music_data)) }
            file_content = File.read(file_path)
            music_data = JSON.parse(file_content)
            music_data << music_hash
            puts music_data
            File.write(file_path, JSON.generate(music_data))
            puts "data added successfully"
        end
    end
end


