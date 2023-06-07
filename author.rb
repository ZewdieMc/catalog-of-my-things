require 'securerandom'

class Author
  attr_accessor :id, :first_name, :last_name, :items

  def initialize(first_name, last_name, items = [])
    @id = SecureRandom.random_number(1000)
    @first_name = first_name
    @last_name = last_name
    @items = items
  end

  def add_item(item)
    items << item
    item.author = self
  end
end
author = Author.new('zewdie','habtie')
puts author.id