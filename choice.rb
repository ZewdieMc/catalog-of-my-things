class Choice
  def initialize
    input = gets.chomp
    case input.to_i
    when 1 then puts '1 - List all books'
    when 2 then puts '2 - List all music albums'
    when 3 then puts '3 - List all movies'
    when 4 then puts '4 - List all games'
    when 5 then puts '5 - List all genres'
    when 6 then puts '6 - List all labels'
    when 7 then puts '7 - List all authors'
    when 8 then puts '8 - List all sources'
    when 9 then puts '9 - Add a book'
    when 10 then puts '10 - Add a music album'
    when 11 then puts '11 - Add a movie'
    when 12 then puts '12 - Add a game'
    when 13 then exit
    else
      puts 'Invalid input'
    end
  end
end

#  menu_options = {
#     '1' => :list_all_books,
#     '2' => :list_all_peoples,
#     '3' => :create_person,
#     '4' => :create_book,
#     '5' => :create_rental,
#     '6' => :list_rentals,
#     '7' => :exit
#   }
