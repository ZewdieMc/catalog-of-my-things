require_relative './books/label'
require 'securerandom'
require 'date'

class Item
  attr_accessor :genre, :author, :label, :publish_date
  attr_reader :id, :archived

  def initialize(publish_date, archived, id = SecureRandom.random_number(1000))
    @id = id
    @publish_date = publish_date
    @archived = archived
    @label = nil
    @genre = nil
    @author = nil
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    Date.today.year - @publish_date.year >= 10
  end
end
