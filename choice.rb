require_relative './books/book_ui'
require_relative './game/game_ui'

class Choice
  OPTIONS = {
    1 => :list_books,
    2 => :list_music_albums,
    3 => :create_author,
    4 => :list_games,
    5 => :list_genres,
    6 => :list_labels,
    7 => :list_authors,
    8 => :list_sources,
    9 => :add_book,
    10 => :add_music_album,
    11 => :add_movie,
    12 => :add_game,
    0 => :exit
  }.freeze

  def initialize
    @book_app = BookActions.new
    @game = GameOptions.new
    input = gets.chomp.to_i
    if OPTIONS[input]
      send(OPTIONS[input])
    else
      puts 'Invalid input'
    end
  end

  def list_books
    puts 'Listing all books'
    @book_app.list_books
  end

  def list_music_albums
    puts 'Listing all music albums'
  end

  def create_author
    @game.create_author
  end

  def list_games
    puts '=======Game List======='
    @game.list_games
  end

  def list_genres
    puts 'Listing all genres'
  end

  def list_labels
    puts 'Listing all labels'
    @book_app.list_labels
  end

  def list_authors
    @game.list_authors
  end

  def list_sources
    puts 'Listing all sources'
  end

  def add_book
    puts 'Adding a book'
    @book_app.add_book
  end

  def add_music_album
    puts 'Adding a music album'
  end

  def add_movie
    puts 'Adding a movie'
  end

  def add_game
    @game.add_game
  end

  def exit
    puts 'Thanks for Using this App'
    Kernel.exit
  end
end
