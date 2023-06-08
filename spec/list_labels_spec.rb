require_relative '../books/book_ui'
require_relative '../books/book'
require_relative '../books/label'
require 'date'
require 'json'

RSpec.describe BookActions do
  before do
    @mock_json_data = <<~JSON
      [
        {
          "title": "Test Book 1",
          "author": "Test author 1",
          "publish_date": "2023-06-07",
          "publisher": "publisher one",
          "cover_state": "good",
          "labels": [{ "id": 1, "name": "gift", "color": "red" }]
        },
        {
          "title": "Test Book 2",
          "author": "Test author 2",
          "publish_date": "2023-06-08",
          "publisher": "publisher two",
          "cover_state": "bad",
          "labels": [{ "id": 2, "name": "buy", "color": "blue" }]
        }
      ]
    JSON

    allow(File).to receive(:read).with('./json_data/books.json').and_return(@mock_json_data)

    @label1 = Label.new(1, 'gift', 'red')
    @label2 = Label.new(2, 'buy', 'blue')
    @book1 = Book.new('Test author 1', Date.new(2023, 6, 7), 'publisher one', 'good')
    @book2 = Book.new('Test author 2', Date.new(2023, 6, 8), 'publisher two', 'bad')
    @book1.label = @label1
    @book2.label = @label2
    @book_app = BookActions.new(file: './json_data/books.json')
    @book_app.books = [@book1, @book2]
  end

  describe '#list_labels' do
    context 'when there are labels in the list' do
      it 'prints the label information' do
        expect { @book_app.list_labels }.to output(/Color: red - Name: gift/).to_stdout
        expect { @book_app.list_labels }.to output(/Color: blue - Name: buy/).to_stdout
      end
    end

    context 'when there are no labels in the list' do
      before { @book_app.books = [] }

      it 'prints a message indicating no labels found' do
        expect { @book_app.list_labels }.to output(/No labels found!/).to_stdout
      end
    end
  end
end
