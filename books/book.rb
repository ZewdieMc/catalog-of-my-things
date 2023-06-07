require_relative '../item'
require 'date'

class Book < Item
  attr_accessor :title, :publisher, :cover_state, :label

  def initialize(title, publish_date, publisher, cover_state, label: [])
    super(publish_date)
    @title = title
    @publisher = publisher
    @cover_state = cover_state
    @labels = []
    @label = label
  end

  def can_be_archived?
    super || @cover_state.downcase == 'bad'
  end

  def add_label
    @labels << label
  end
end
