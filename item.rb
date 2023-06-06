require 'securerandom'
require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :publish_date

  def initialize(publish_date, archived)
    @id = SecureRandom.random_number(1000)
    @publish_date = publish_date
    @archived = archived
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
    else
      puts 'Item is already archived'
    end
  end

  private

  def can_be_archived?
    Date.today.year - @publish_date.year >= 10
  end
end


