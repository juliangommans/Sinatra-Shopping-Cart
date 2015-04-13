require_relative '../app/models/product'
require_relative '../config/database'

products = File.readlines('products.txt')
until products.empty?
		line = products.slice!(0,3)
		Product.create!(item_name: line[0].chomp, item_price: line[1], description: line[2].chomp)
end