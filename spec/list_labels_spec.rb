require_relative '../books/book_ui'
require_relative '../books/book'
require_relative '../books/label'
require 'date'
require 'json'

RSpec.describe BookActions do
  before do
    @book_app = BookActions.new(file: './json_data/books.json')
  end

 describe '#list_labels' do
    context 'when there are labels in the list' do
      before do
        @label1 = Label.new(1, 'gift', 'red')
        @label2 = Label.new(2, 'buy', 'blue')
        @book1 = Book.new('Test title 1', Date.new(2023, 6, 7), 'publisher one', 'good')
        @book1.label = @label1
        @book2 = Book.new('Test title 2', Date.new(2023, 6, 8), 'publisher two', 'bad')
        @book2.label = @label2
        @book_app.books = [@book1, @book2]
      end

      it 'prints the label information' do
        expect { @book_app.list_labels }.to output(/Color: red - Name: gift/).to_stdout
        expect { @book_app.list_labels }.to output(/Color: blue - Name: buy/).to_stdout
      end
    end

    context 'when there are no labels in the list' do
      before do
        @book_app.books = []
      end

      it 'prints a message indicating no labels found' do
        expect { @book_app.list_labels }.to output(/No labels found!/).to_stdout
      end
    end
  end
end
