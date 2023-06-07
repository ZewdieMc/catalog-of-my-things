require 'securerandom'
require './item'
class Author
  attr_accessor :first_name, :last_name
  attr_reader :id, :items

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
