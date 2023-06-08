require_relative 'item'
require_relative 'options'
require_relative 'choice'
require_relative './books/book_ui'

class Main
  
  def initialize(book_app = BookActions.new, game = GameOptions.new)
    @book_app = book_app
    @game = game
    @choice = Choice.new(@book_app, @game)
  end
  def run
    puts "Welcome to our Catalog of things \n"
    puts "Please choose an option by entering a number!\n"
    loop do
      Options.new
      @choice.run
    end
  end
end

main = Main.new
main.run
