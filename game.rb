require './item'
require 'date'

class Game < Item
  def initialize(publish_date, archived, multiplayer, last_played_at)
    super(publish_date, archived)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  private

  def can_be_archived?
    super && Date.today.year - @last_played_at.year > 2
  end
end

game = Game.new('12/15/2000', false, true, '12/15/2023')
puts game.can_be_archived?
