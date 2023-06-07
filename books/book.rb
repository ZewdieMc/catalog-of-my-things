require_relative '../item'
require 'date'

class Book < Item
  attr_reader :title
  attr_accessor :publisher, :cover_state, :label

  def initialize(title, publish_date, publisher, cover_state, label: nil)
    super(publish_date, false)
    @title = title
    @publisher = publisher
    @cover_state = cover_state
    @label = label
  end

  def can_be_archived?
    super || @cover_state.downcase == 'bad'
  end
end

