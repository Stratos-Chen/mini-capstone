class Category < ApplicationRecord
  has_many :product_categories
  has_many :products ,through: :product_categories

  #note: type down product method later
end
