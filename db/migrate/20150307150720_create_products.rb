class CreateProducts < ActiveRecord::Migration
  def change
  	create_table :products do |t|
  		t.string :item_name
  		t.integer :item_price
  		t.string :description
  		t.integer :cart_id
  		t.timestamps
  	end
  end
end
