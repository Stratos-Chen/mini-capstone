class Product < ApplicationRecord

  has_many :carted_products
  has_many :orders, through: :carted_products
  has_many :product_categories
  has_many :categories, through: :product_categories

  #write down categories method later

  validates :name, :description, uniqueness: true
  validates :price, numericality: true
  validates :name, :price, :description, presence: true
  def is_discounted?
    if price < 10
      return true
    else
      return false
    end
  end

  def tax
    tax = price * 0.09
  end

  def total
    total = price + tax
  end

  belongs_to :supplier
  # def supplier
  #   Supplier.find_by(id: supplier_id)
  # end
  has_many :images
end
