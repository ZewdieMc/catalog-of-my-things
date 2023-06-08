# require_relative '../books/book_ui'
# require_relative '../books/book'
# require_relative '../books/label'
# require 'date'

# RSpec.describe Book do
#   describe '#can_be_archived?' do
#     context 'when cover state is "good" and publish date is more than 10 years ago' do
#       it 'returns true' do
#         book = Book.new('Test Book', Date.today - (11 * 365), 'Test Publisher', 'good')
#         expect(book.can_be_archived?).to be(true)
#       end
#     end

#     context 'when cover state is "good" and publish date is less than 10 years ago' do
#       it 'returns false' do
#         book = Book.new('Test Book', Date.today - (9 * 365), 'Test Publisher', 'good')
#         expect(book.can_be_archived?).to be(false)
#       end
#     end

#     context 'when cover state is "bad"' do
#       it 'returns true' do
#         book = Book.new('Test Book', Date.today, 'Test Publisher', 'bad')
#         expect(book.can_be_archived?).to eq(true)
#       end
#     end
#   end
# end
