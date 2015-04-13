class Cart < ActiveRecord::Base
  belongs_to :users
  has_many :products
 
end
