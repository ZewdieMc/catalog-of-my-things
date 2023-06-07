require_relative 'book'
require_relative 'label'
require 'json'

class BookActions
  FILE_PATH = 'C:/Microverse All/Microverse New/Module 4/catalog-of-my-things/json_data/books.json'.freeze

  attr_accessor :books

  def initialize(file: FILE_PATH)
    @file = file
    @books = load_books || []
  end

  def list_books
    if @books.empty?
      puts 'No books found!'
    else
      puts "\n"
      puts '________________ Book Info _________________'
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
    labels = @books.map(&:label).flatten.uniq
    puts "\n"

    if labels.empty?
      puts "No labels found!\n"
    else
      puts '--------------- Label Info ---------------'
      labels.each_with_index do |label, index|
        name = label.respond_to?(:name) ? label.name : label['name']
        color = label.respond_to?(:color) ? label.color : label['color']

        puts "Color: #{color} - Name: #{name}\n"
        puts '------------------------------------------'
      end
    end
  end

  def add_book(title:, publish_date:, publisher:, cover_state:, label: [])
    @books ||= [] # initialize @books to an empty array if it is nil
    book = Book.new(title, publish_date, publisher, cover_state, label)
    @books << book # add new book to array
    save_books # save updated array to file
  end

  def create_book
    print 'Enter the book title: '
    title = gets.chomp

    print 'Enter the book publisher: '
    publisher = gets.chomp

    print 'Enter the cover state of the book: (G)ood or (B)ad? '
    cover_state = gets.chomp.upcase
    case cover_state
    when 'B'
      cover_state = 'bad'
    when 'G'
      cover_state = 'good'
    end

    print 'Enter the publish date of the book (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)

    Book.new(title, publish_date, publisher, cover_state)
  end

  def create_label(book)
    print 'Enter label name (e.g: buy, gift, found): '
    name = gets.chomp.downcase

    print 'Enter the book label color: '
    color = gets.chomp.downcase

    Label.new(book.id, name, color)
  end

  def load_books
    return [] unless File.exist?(@file) && !File.zero?(@file)

    json_data = File.read(@file) # read JSON data from file
    begin
      books_data = JSON.parse(json_data) # parse JSON into array of objects
      books_data.map do |book|
        # Convert all keys in the hash to symbols
        book = Hash[book.map { |k, v| [k.to_sym, v] }]
        Book.new(book[:title], book[:publish_date], book[:publisher], book[:cover_state], label: book[:label])
      end
    rescue JSON::ParserError
      []
    end
  end

  def save_books
    books_json = { books: @books.map do |book|
      label_data = case book.label
      when Label
        { name: book.label.name, color: book.label.color }
      else
        book.label
      end
      {
        title: book.title,
        publish_date: book.publish_date,
        publisher: book.publisher,
        cover_state: book.cover_state,
        label: label_data
      }
    end }

    File.write(@file, books_json.to_json) # generate JSON string and write to file
  end
end
