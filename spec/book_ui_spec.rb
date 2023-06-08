# require 'rspec'
# require_relative '../books/book_ui'
# require_relative '../books/book'
# require_relative '../books/label'
# require 'date'


# describe BookActions do
#   let(:json_data) do
#     [
#       {
#         author: 'J.K. Rowling',
#         publisher: 'Bloomsbury Publishing',
#         publish_date: '1997-06-26',
#         cover_state: 'good',
#         label: { name: 'buy', color: 'blue' }
#       },
#       {
#         author: 'Stephen King',
#         publisher: 'Viking Press',
#         publish_date: '1975-04-05',
#         cover_state: 'bad'
#       },
#       {
#         author: 'Harper Lee',
#         publisher: 'J. B. Lippincott & Co.',
#         publish_date: '1960-07-11',
#         cover_state: 'good',
#         label: { name: 'gift', color: 'red' }
#       }
#     ].to_json
#   end
#   let(:file_path) { 'spec/mock_data.json' }

#   before do
#     allow(File).to receive(:exist?).with(file_path).and_return(true)
#     allow(File).to receive(:read).with(file_path).and_return(json_data)
#     @book_actions = BookActions.new(file: file_path)
#   end

#   describe '#list_books' do
#     it 'lists all books if available' do
#       expected_output = "--------------- Book Info ---------------\nAuthor: J.K. Rowling\nPublisher: Bloomsbury Publishing\nCover State: good\nPublish Date: 1997-06-26\n------------------------------------------\nAuthor: Stephen King\nPublisher: Viking Press\nCover State: bad\nPublish Date: 1975-04-05\n------------------------------------------\nAuthor: Harper Lee\nPublisher: J. B. Lippincott & Co.\nCover State: good\nPublish Date: 1960-07-11\n------------------------------------------\n"
#       expect { @book_actions.list_books }.to output(expected_output).to_stdout
#     end

#     it 'displays a message if no books are found' do
#       @book_actions.books = []

#       expect { @book_actions.list_books }.to output("No books found!\n").to_stdout
#     end
#   end

#   describe '#list_labels' do
#     it 'lists all the available labels' do
#       expected_output = "--------------- Label Info ---------------\nColor: blue - Name: buy\n------------------------------------------\nColor: red - Name: gift\n------------------------------------------\n"
#       expect { @book_actions.list_labels }.to output(expected_output).to_stdout
#     end

#     it 'displays a message if no labels are found' do
#       @book_actions.books.each { |book| book.label = nil }

#       expect { @book_actions.list_labels }.to output("No labels found!\n").to_stdout
#     end
#   end

#   describe '#add_book' do
#     before do
#       allow(@book_actions).to receive(:gets).and_return(*inputs)
#       @book_actions.add_book
#     end

#     context 'when valid inputs are provided' do
#       let(:inputs) { ["J.R.R Tolkien\n", "Houghton Mifflin Harcourt\n", "1954-07-29\n", "g\n", "borrow\n", "purple\n"] }

#       it 'adds the book to the books array' do
#         expect(@book_actions.books.size).to eq 4

#         new_book = @book_actions.books.last
#         expect(new_book.author).to eq 'J.R.R Tolkien'
#         expect(new_book.publisher).to eq 'Houghton Mifflin Harcourt'
#         expect(new_book.publish_date.to_s).to eq '1954-07-29'
#         expect(new_book.cover_state).to eq 'good'
#         expect(new_book.label.name).to eq 'borrow'
#         expect(new_book.label.color).to eq 'purple'
#       end

#       it 'saves the new book to the JSON file' do
#         file_data = JSON.parse(File.read(file_path), symbolize_names: true)
#         new_book_data = file_data.last

#         expect(new_book_data[:author]).to eq 'J.R.R Tolkien'
#         expect(new_book_data[:publisher]).to eq 'Houghton Mifflin Harcourt'
#         expect(new_book_data[:publish_date]).to eq '1954-07-29'
#         expect(new_book_data[:cover_state]).to eq 'good'
#         expect(new_book_data[:label][:name]).to eq 'borrow'
#         expect(new_book_data[:label][:color]).to eq 'purple'
#       end

#       it 'displays a success message' do
#         expect { @book_actions.add_book }.to output("------------------------------------------\nBook added successfully\n").to_stdout
#       end
#     end

#     context 'when invalid inputs are provided' do
#       let(:inputs) { ["J.R.R Tolkien\n", "Houghton Mifflin Harcourt\n", "INVALID DATE\n", "invalid_cover_state\n", "borrow\n", "purple\n"] }

#       it 'does not add the book to the books array' do
#         expect(@book_actions.books.size).to eq 3
#       end

#       it 'does not save the new book to the JSON file' do
#         file_data = JSON.parse(File.read(file_path), symbolize_names: true)
#         expect(file_data.size).to eq 3
#       end

#       it 'displays an error message' do
#         expected_output = "Enter the book Author: Enter the book publisher: Enter the publish date of the book (YYYY-MM-DD): An error occurred while trying to parse the date\nEnter the cover state of the book: (G)ood or (B)ad?Enter label name (e.g: buy, gift, found): Enter the book label color: ------------------------------------------\n"
#         expect { @book_actions.add_book }.to output(expected_output).to_stdout
#       end
#     end
#   end
# end

