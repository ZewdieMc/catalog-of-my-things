require_relative './albumaction/albumact'
require_relative './books/book_ui'

class Choice
  OPTIONS = {
    1 => :list_books,
    2 => :list_music_albums,
    3 => :list_movies,
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
    input = gets.chomp.to_i
    if OPTIONS[input]
      send(OPTIONS[input])
    else
      puts 'Invalid input'
    end
  end

  def list_books
    puts '1 - List all books'
  end

  def list_music_albums
    puts '2 - List all music albums'
    alb = Albumaction.new
    alb.getmusicalbum
  end

  def list_movies
    puts '3 - List all movies'
  end

  def list_games
    puts '4 - List all games'
  end

  def list_genres
    puts '5 - List all genres'
    genre = Albumaction.new
    genre.getgenre
  end

  def list_labels
    puts '6 - List all labels'
  end

  def list_authors
    puts '7 - List all authors'
  end

  def list_sources
    puts '8 - List all sources'
  end

  def add_book
    puts '9 - Add a book'
  end

  def addmusicalbum
    puts '10 - Add a music album'
    add_album = Albumaction.new
    add_album.add_music_album
  end

  def add_movie
    puts '11 - Add a movie'
  end

  def add_game
    puts '12 - Add a game'
  end

  def exit
    puts 'Thanks for Using this App'
    Kernel.exit
  end
end
