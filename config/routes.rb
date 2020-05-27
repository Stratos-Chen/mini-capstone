Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end
  namespace :api do
    get "/products" => "products#product_list"
    get "/product1" => "products#product_one"
    get "/product2" => "products#product_two"
    get "/product3" => "products#product_three"
  end
end
