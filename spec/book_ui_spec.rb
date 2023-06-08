# Book UI Spec test
require_relative '../books/book_ui'
require_relative '../books/book'
require_relative '../books/label'
require 'date'
require 'json'



RSpec.describe BookActions do
  describe '#load_books' do
    context 'when the JSON file exists and contains valid data' do
      before do
        @mock_json_data = <<~JSON
          [
            {"author": "Test author 1", "publish_date": "2023-06-07"},
            {"author": "Test author 2", "publish_date": "2023-06-08"}
          ]
        JSON
        allow(File).to receive(:read).with('./json_data/books.json').and_return(@mock_json_data)
        @book_app = BookActions.new(file: './json_data/books.json')
      end

      it 'returns an array of Book objects' do
        expect(@book_app.load_books).to all(be_a(Book))
      end

      it 'loads the correct book information' do
        books = @book_app.load_books
        expect(books[0].author).to eq('Test author 1')
        expect(books[0].publish_date).to eq(Date.new(2023, 6, 7))
        expect(books[1].author).to eq('Test author 2')
        expect(books[1].publish_date).to eq(Date.new(2023, 6, 8))
      end
    end

    context 'when the JSON file does not exist' do
      before do
        allow(File).to receive(:exist?).with('./json_data/books.json').and_return(false)
        @book_app = BookActions.new(file: './json_data/books.json')
      end

      it 'returns an empty array' do
        expect(@book_app.load_books).to eq([])
      end
    end

    context 'when the JSON file is empty' do
      before do
        allow(File).to receive(:exist?).with('./json_data/books.json').and_return(true)
        allow(File).to receive(:empty?).with('./json_data/books.json').and_return(true)
        @book_app = BookActions.new(file: './json_data/books.json')
      end

      it 'returns an empty array' do
        expect(@book_app.load_books).to eq([])
      end
    end

    context 'when the JSON file contains invalid data' do
      before do
        @mock_json_data = <<~JSON
          [
            {"author": "Test author 1", "publish_date": "2023-06-07"},
            {"author": "Test author 2", "publish_date": "2023-06-08"},
            {"invalid_field": "invalid data"}
          ]
        JSON
        allow(File).to receive(:read).with('./json_data/books.json').and_return(@mock_json_data)
        @book_app = BookActions.new(file: './json_data/books.json')
      end

      it 'returns only valid book objects' do
        expect(@book_app.load_books).to all(be_a(Book))
      end
    end
  end
end
