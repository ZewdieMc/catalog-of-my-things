#!/usr/bin/env ruby

require_relative 'item'
require_relative 'options'
require_relative 'choice'
require_relative './books/book_ui'

class Main
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
