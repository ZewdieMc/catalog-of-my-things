require_relative 'item'
require_relative 'options'
require_relative 'choice'

class Main
  def initialize
    @item = Item.new('12/15/2000', false)
  end

  def run
    puts "Welcome to our Catalog of things \n"
    puts "Please choose an option by entering a number!\n"
    loop do
      Options.new
      Choice.new
    end
  end
end

main = Main.new
main.run
