require_relative 'item'

# main.rb file code goes here


class Main
    def self.run
        item = Item.new("12/15/2000", false)
        puts item.publish_date
    end
end

Main.run