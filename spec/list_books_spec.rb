require_relative '../books/book_ui'
require_relative '../books/book'
require_relative '../books/label'
require 'date'
require 'json'

RSpec.describe BookActions do
  before do
    @book_app = BookActions.new(file: './json_data/books.json')
  end

  describe '#list_books' do
    context 'when there are books in the list' do
      before do
        @book1 = Book.new('Test title 1', Date.new(2023, 6, 7), 'publisher one', 'good')
        @book2 = Book.new('Test title 2', Date.new(2023, 6, 8), 'publisher two', 'bad')
        @book_app.books = [@book1, @book2]
      end

      it 'prints the book information' do
        expect { @book_app.list_books }.to output(/Title: Test title 1/).to_stdout
        expect { @book_app.list_books }.to output(/Publisher: publisher two/).to_stdout
      end
    end

    context 'when there are no books in the list' do
      before do
        @book_app.books = []
      end

      it 'prints a message indicating no books found' do
        expect { @book_app.list_books }.to output(/No books found!/).to_stdout
      end
    end
  end
end