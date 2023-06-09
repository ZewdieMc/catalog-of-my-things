require_relative '../game'
require_relative '../author'

class GameOptions
  GAMES_FILE = "#{__dir__}/../json_data/games.json".freeze
  AUTHORS_FILE = "#{__dir__}/../json_data/authors.json".freeze

  attr_accessor :games, :authors

  def initialize
    @games = load_games || []
    @authors = load_authors || []
  end

  def add_game
    print 'Enter the publish date of the game (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Is the game multiplayer? [Y/N]: '
    multiplayer_input = gets.chomp
    multiplayer = %w[N n NO no No].include? multiplayer_input ? false : true
    last_played_at = Date.today
    game = Game.new(publish_date, multiplayer, last_played_at)
    author = choose_author
    author.add_item(game)
    store_authors
    @games << game
    puts 'Game created successfully.'
    store_games
  end

  def choose_author
    author = nil
    puts 'Do you want to add a new author or choose from available authors? [N/L]? '
    puts 'N: New author'
    puts 'L: List authors' unless authors.empty?
    input = gets.chomp.upcase
    if input == 'N'
      print 'Enter game author First Name: '
      first_name = gets.chomp
      print 'Enter game author Last Name: '
      last_name = gets.chomp
      author = Author.new(first_name, last_name)
      @authors.push(author)
    elsif input == 'L'
      puts 'Select an author from the list below:'
      @authors.each.with_index { |auth, index| puts "#{index}): #{auth.first_name} #{auth.last_name}" }
      author_index = gets.chomp.to_i
      author = @authors[author_index]
    end
    author
  end

  def list_games
    puts 'There are no games in the library' if @games.empty?
    load_games
    @games.each do |game|
      puts game.label.nil? ? 'Label: No label' : "Label: #{game.label.title}"
      puts "Publish date: #{game.publish_date}"
      puts game.multiplayer == true ? 'Player: multiplayer' : 'Player: singleplayer'
      puts "Last played at: #{game.last_played_at}"
      puts game.author.nil? ? 'Author: No author' : "Author: #{game.author.first_name} #{game.author.last_name}"
      puts game.genre.nil? ? 'Genre: No genre' : "Genre: #{game.genre.name}"
      puts '============================'
    end
    puts
  end

  def list_authors
    @authors = @games.map(&:author).uniq
    puts 'There are no authors in the library' if @authors.empty?
    @authors.each.with_index do |author, index|
      puts "Author #{index + 1}: #{author.first_name} #{author.last_name}"
      puts '============================'
    end
  end

  def store_games
    games_arr = []
    @games.each do |game|
      puts game.author
      games_arr.push({
                       id: game.id,
                       publish_date: game.publish_date,
                       multiplayer: game.multiplayer,
                       last_played_at: game.last_played_at,
                       label: game.label,
                       author: game.author.nil? ? nil : "#{game.author.first_name} #{game.author.last_name}"
                     })
    end
    File.write(GAMES_FILE, JSON.pretty_generate(games_arr))
  end

  def store_authors
    authors_arr = []
    @authors.each do |author|
      authors_arr.push({
                         first_name: author.first_name,
                         last_name: author.last_name,
                         items: author.items.map do |item|
                                  {
                                    id: item.id,
                                    publish_date: item.publish_date,
                                    archived: item.archived
                                  }
                                end
                       })
    end
    File.write(AUTHORS_FILE, JSON.pretty_generate(authors_arr))
  end

  def load_games
    return [] if !File.exist?(GAMES_FILE) || File.empty?(GAMES_FILE)

    games_data = JSON.parse(File.read(GAMES_FILE), symbolize_names: true)
    return [] unless games_data.is_a?(Array)

    @games = []
    games_data.each do |game_data|
      publish_date = game_data[:publish_date]
      multiplayer = game_data[:multiplayer]
      last_played_at = game_data[:last_played_at]
      game = Game.new(publish_date, multiplayer, last_played_at)
      game.label = game_data[:label]
      author = Author.new(game_data[:author]['first_name'], game_data[:author]['last_name'])
      game.author = author
      game.genre = game_data[:genre]
      @games.push(game)
    end
    @games
  end

  def load_authors
    return [] if !File.exist?(AUTHORS_FILE) || File.empty?(AUTHORS_FILE)

    author_data = JSON.parse(File.read(AUTHORS_FILE), symbolize_names: true)
    return [] unless author_data.is_a?(Array)

    @authors = []
    author_data.each do |author_d|
      first_name = author_d[:first_name]
      last_name = author_d[:last_name]
      author = Author.new(first_name, last_name)
      author_d[:items].map do |item|
        author.add_item(Item.new(item[:publish_date], item[:archived], item[:id]))
      end
      @authors.push(author)
    end
    @authors
  end
end
