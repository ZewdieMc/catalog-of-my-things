require_relative './books/book_ui'
require_relative './game/game_ui'

class Choice
  OPTIONS = {
    1 => :list_books,
    2 => :list_music_albums,
    3 => :list_games,
    4 => :list_genres,
    5 => :list_labels,
    6 => :list_authors,
    7 => :add_book,
    8 => :add_music_album,
    9 => :add_game,
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

  def add_book
    puts 'Adding a book'
    @book_app.add_book
  end

  def add_music_album
    puts 'Adding a music album'
  end

  def add_game
    @game.add_game
  end

  def exit
    puts 'Thanks for Using this App'
    Kernel.exit
  end
end
