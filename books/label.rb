require_relative '../item'

class Label
  attr_accessor :id, :name, :color, :items

  def initialize(id, name, color)
    @id = id
    @name = name
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
  end

  def remove_item(item)
    @items.delete(item)
    item.label = nil
  end
end
