require_relative '../game'
require_relative '../author'

class GameOptions
  attr_accessor :games, :authors

  @@games = []
  @@authors = []

  def add_game
    print 'Enter the publish date of the game (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Is the game multiplayer? [Y/N]: '
    multiplayer_input = gets.chomp
    multiplayer = %w[N n NO no No].include? multiplayer_input ? false : true
    last_played_at = Date.today
    game = Game.new(publish_date, multiplayer, last_played_at)
    print "Enter game author First Name: "
    first_name = gets.chomp
    print "Enter game author Last Name: "
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    author.add_item(game)
    @@games.push(game)
    puts "Game created successfully."
  end

  def list_games
    puts 'There are no games in the library' if @@games.empty?
    @@games.each do |game|
      puts game.label === nil ? "Label: No label" : "Label: #{game.label.title}"
      puts "Publish date: #{game.publish_date}"
      puts game.multiplayer === true ? "Player: multiplayer" : "Player: singleplayer"
      puts "Last played at: #{game.last_played_at}"
      puts game.author === nil ? "Author: No author" : "Author: #{game.author.first_name} #{game.author.last_name}"
      puts game.genre === nil ? "Genre: No genre" : "Genre: #{game.genre.name}"
      puts "============================"
    end
    puts
  end

  def list_authors
    @@authors = @@games.map(&:author).uniq
    puts 'There are no authors in the library' if @@authors.empty?
    @@authors.each.with_index do |author, index|
      puts "Author #{index +1}: #{author.first_name} #{author.last_name}"
      puts "============================"
    end
  end
end
