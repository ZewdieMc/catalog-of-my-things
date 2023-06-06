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
    13 => :exit
  }.freeze

  def initialize
    input = gets.chomp.to_i
    if OPTIONS[input]
      send(OPTIONS[input])
    else
      puts 'Invalid input'
    end
  end

  def list_books
    puts 'List all books'
  end

  def list_music_albums
    puts 'List all music albums'
  end

  def list_movies
    puts 'List all movies'
  end

  def list_games
    puts 'List all games'
  end

  def list_genres
    puts 'List all genres'
  end

  def list_labels
    puts 'List all labels'
  end

  def list_authors
    puts 'List all authors'
  end

  def list_sources
    puts 'List all sources'
  end

  def add_book
    puts 'Add a book'
  end

  def add_music_album
    puts 'Add a music album'
  end

  def add_movie
    puts 'Add a movie'
  end

  def add_game
    puts 'Add a game'
  end

  def exit
    Kernel.exit
  end
end
