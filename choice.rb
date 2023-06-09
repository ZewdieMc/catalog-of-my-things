require_relative './albumaction/albumact'
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

  def initialize(book_app, game)
    @book_app = book_app
    @game = game
  end

  def run
    input = gets.chomp.to_i
    if OPTIONS[input]
      send(OPTIONS[input])
    else
      puts 'Invalid input'
    end
  end

  def list_books
    puts 'All books'
    @book_app.list_books
  end

  def list_music_albums
    puts 'All music albums'
    alb = Albumaction.new
    alb.getmusicalbum
  end

  def list_games
    puts '=======Games List======='
    @game.list_games
  end

  def list_genres
    puts '5 - List all genres'
    genre = Albumaction.new
    genre.getgenre
  end

  def list_labels
    puts 'Listing all labels'
    @book_app.list_labels
  end

  def list_authors
    puts '=======Authors List======='
    @game.list_authors
  end

  def add_book
    @book_app.add_book
  end

  def add_music_album
    puts '10 - Add a music album'
    add_album = Albumaction.new
    add_album.addmusicalbum
  end

  def add_game
    @game.add_game
  end

  def exit
    puts 'Thanks for Using this App'
    Kernel.exit
  end
end
