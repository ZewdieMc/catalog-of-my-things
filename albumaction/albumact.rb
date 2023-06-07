require 'json'

class Albumaction
    def get_music_album
        file_path = './music.json'
        if File.exist?(file_path)
            file_content = File.read(file_path)
            music_data = JSON.parse(file_content)
            if music_data.is_a?(Array) && music_data.empty?
                puts "Empty album"
            else
                puts "album there"
            end
        else
            music_data = []
            File.open(file_path, 'w') { |file| file.write(JSON.generate(music_data)) }
            puts "No album here"
        end
    end
end
