require_relative '../item'
require 'date'

class Book < Item
  attr_accessor :title, :publish_date, :publisher, :cover_state, :label

  def initialize(title, publish_date, publisher, cover_state, label: nil)
    super(title, publish_date)
    @title = title
    @publish_date = publish_date
    @publisher = publisher
    @cover_state = cover_state
    @label = label
  end

  def can_be_archived?
    super || @cover_state.downcase == 'bad'
  end

  def add_label
    @labels << label
  end
end

#Fix Indentation Width
