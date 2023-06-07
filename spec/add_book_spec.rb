require_relative '../books/book_ui'
require_relative '../books/book'
require_relative '../books/label'
require 'date'
require 'json'

RSpec.describe BookActions do
  before do
    @book_app = BookActions.new(file: './json_data/books.json')
  end

  describe '#add_book' do
    it 'adds a new book with the given attributes' do
      allow(@book_app).to receive(:gets).and_return(
        'Test title',
        'publisher one',
        '2023-06-07',
        'b',
        'gift',
        'red'
      )
      @book_app.add_book
      # book = @book_app.books.last

      expect(book.title).to eq('Test title')
      expect(book.publisher).to eq('publisher one')
      expect(book.publish_date).to eq(Date.new(2023, 6, 7))
      expect(book.cover_state).to eq('bad')
      expect(book.label.name).to eq('gift')
      expect(book.label.color).to eq('red')
    end
  end
end
