class Author
    attr_accessor :first_name, :last_name, :items

    def initialize (first_name, last_name, items = [])
        @id = SecureRandom.random(1000)
        @first_name = first_name
        @last_name = last_name
        @items = items
    end

    def add_item(item)
        items << item
        item.author = self
    end
end