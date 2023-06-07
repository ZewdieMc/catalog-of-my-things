require_relative 'book'
require_relative 'label'
require 'json'

class BookActions
  FILE_PATH = 'C:/Microverse All/Microverse New/Module 4/catalog-of-my-things/json_data/books.json'.freeze

  attr_accessor :books

  def initialize(file_path: FILE_PATH)
    @file_path = file_path
    @books = load_books || []
  end

  def list_books
    if @books.empty?
      puts 'No books found!'
    else
      puts "\n________________ Book Info ________________\n"
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
      labels.each do |label|
        name = label.respond_to?(:name) ? label.name : label['name']
        color = label.respond_to?(:color) ? label.color : label['color']

        puts "Color: #{color} - Name: #{name}\n"
        puts '------------------------------------------'
      end
    end
  end

  def add_book(title:, publish_date:, publisher:, cover_state:, label: [])
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
    cover_state = case cover_state
                  when 'B'
                    'bad'
                  when 'G'
                    'good'
                  else
                    'unknown'
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
    if File.exist?(@file_path)
      data = JSON.parse(File.read(@file_path))
      data.map do |book_data|
        label_data = case book_data['label']
                     when Label
                       book_data['label']
                     when Array
                       Label.new(book_data['id'], book_data['label'][0]['name'], book_data['label'][0]['color'])
                     when String
                       Label.new(book_data['id'], book_data['label'], nil)
                     else
                       nil
                     end
        Book.new(book_data['title'], book_data['publish_date'], book_data['publisher'], book_data['cover_state'], label: label_data)
      end
    else
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

    File.write(@file_path, books_json.to_json) # generate JSON string and write to file
  end
end

  # def add_book(title:, publish_date:, publisher:, cover_state:, label: [])
  #   @books ||= [] # initialize @books to an empty array if it is nil
  #   book = Book.new(title, publish_date, publisher, cover_state, label)
  #   @books << book # add new book to array
  #   save_books # save updated array to file
  # end

