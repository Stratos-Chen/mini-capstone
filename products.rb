require "http"
require "tty-table"

response = HTTP.get("http://localhost:3000/api/products")
products = response.parse

index = 0
while index < products.length
  pp products[index]
  index = index + 1
end

product_table = TTY::Table.new ['name', 'price', 'image_url', 'description'], ['green onion', '1', 'https://specialtyproduce.com/sppics/2223.png', 'A tall onion used as a garnish']

product_table.render[:basic]

puts product_table