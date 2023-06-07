require_relative 'book'
require_relative 'label'
require 'json'

class BookActions
  FILE_PATH = "#{__dir__}/../json_data/books.json".freeze

  attr_accessor :books

  def initialize(file: FILE_PATH)
    @file = file
    @books = load_books || []
  end

  def list_books
    if @books.empty?
      puts 'No books found!'
    else
      puts "\n--------------- Book Info ---------------"
      @books.each do |book|
        puts "Title: #{book.title}"
        puts "Publisher: #{book.publisher}"
        puts "Cover State: #{book.cover_state}"
        puts "Publish Date: #{book.publish_date}"
        puts '------------------------------------------'
      end
    end
  end

  def list_labels
    labels = @books.map(&:label).uniq
    puts "\n--------------- Label Info ---------------"

    if labels.empty?
      puts 'No labels found!'
    else
      labels.each do |label|
        name = label.name
        color = label.color
        puts "Color: #{color} - Name: #{name}"
        puts '------------------------------------------'
      end
    end
  end

  def add_book
    print 'Enter the book title: '
    title = gets.chomp

    print 'Enter the book publisher: '
    publisher = gets.chomp

    print 'Enter the publish date of the book (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)

    cover_state = ''
    until %w[g b].include?(cover_state)
      print 'Enter the cover state of the book: (G)ood or (B)ad?'
      cover_state = gets.chomp.downcase
    end

    print 'Enter label name (e.g: buy, gift, found): '
    name = gets.chomp.downcase

    print 'Enter the book label color: '
    color = gets.chomp.downcase

    book = Book.new(title, publish_date, publisher, cover_state == 'g' ? 'good' : 'bad')
    book.label = Label.new(1, name, color)
    @books << book

    puts '------------------------------------------', 'Book added successfully'
    save_books
  end

  def load_books
    return [] unless File.exist?(@file) && !File.empty?(@file)

    begin
      json_data = File.read(@file)
      books_data = JSON.parse(json_data, symbolize_names: true)
      return [] unless books_data.is_a?(Array)

      books_data.map do |book|
        Book.new(
          book[:title],
          book[:publish_date],
          book[:publisher],
          book[:cover_state],
          label: book[:label]
        )
      end
    rescue Errno::ENOENT, JSON::ParserError => e
      puts "An error occurred while trying to load books: #{e.message}"
      []
    end
  end

  def save_books
    books_json = @books.map do |book|
      label_data = book.label.is_a?(Label) ? { name: book.label.name, color: book.label.color } : book.label
      {
        title: book.title,
        publish_date: book.publish_date,
        publisher: book.publisher,
        cover_state: book.cover_state,
        label: label_data
      }
    end

    File.write(@file, books_json.to_json)
  end
end
