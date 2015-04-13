enable :sessions

get '/' do
	@session = check_session(session)
	erb :index
end

get '/signup' do
	@session = check_session(session)
	erb :signup
end

post '/signup' do
	@session = check_session(session)
	@validation = ''
	if params[:password1] == params[:password2]
		@user = User.create(user_name: params[:username], user_password: params[:password1])
		if @user.valid?
			@user.save
			session[:user_id] = @user.id
			@session = check_session(session)
			erb :index
		else
			test = []
			if @user.errors.any?
    		@user.errors.full_messages.each do |msg| 
       		test << msg 
    		end 
 			end
 			@validation = test.join(' - ')
 			@validation.gsub!("User","Your")
			erb :signup
		end
	else
		@validation = "I'm sorry, your passwords do not match."
		erb :signup
	end
end

post '/login' do
@session = check_session(session)
    @user = User.authenticate(params[:username],params[:password])
    if @user.nil?
      redirect '/'
    else
      session[:user_id] = @user.id
      erb :user_page
    end
 end

post '/logout' do
  @session = check_session(session)
  session.clear
  redirect '/'
end

def check_session(session)
	session[:user_id]
end