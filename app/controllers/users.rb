get '/users/:user_id' do
  @user = User.find(params[:user_id])
  erb :user_profile
end

get '/signup' do
  @errors = flash[:errors] if flash[:errors]
  erb :signup
end

post '/signup' do
  user = User.new(email: params[:email])
  user.password = params[:password]
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{@user.id}"
  else
    flash[:errors] = user.errors
    redirect '/signup'
  end
end

get '/login' do
  @errors = flash[:errors] if flash[:errors]
  erb :login
end

post '/login' do
  @user = User.find_by(email: params[:email])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    flash[:errors] = ["invalid email or password"]
    redirect to 'login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end
