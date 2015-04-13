enable :sessions

get '/products' do
	@session = check_session(session)
	@product_list = Product.all
	@product_list.to_a
erb :products
end

get '/products/:item' do
	@session = check_session(session)
	@item = Product.find_by(item_name: params[:item])

erb :item
end

post '/cart/:item' do
	@session = check_session(session)
	Cart.create!(item_id: params[:item], user_id: session[:user_id])
	redirect '/cart'
end

get '/cart' do
	@session = check_session(session)
	@cart = Cart.all.to_a
	@cart.select! do
	  Cart.find_by(user_id: session[:user_id])
	end
	@items = []
	@cart.each do |item|
		@items << Product.find_by(id: item.item_id)
	end
	@total = 0
	@items.each do |price|
		@total += price.item_price
	end
erb :cart
end

post '/remove/:id' do
	delete = Cart.find_by(user_id: session[:user_id], item_id: params[:id])
	delete.destroy!
redirect '/cart'
end

post '/buy' do

Cart.where(user_id: session[:user_id]).find_each do |item|
	item.destroy!
end

redirect '/'
end

def check_session(session)
	session[:user_id]
end