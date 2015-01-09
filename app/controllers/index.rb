get '/' do
  @errors = flash[:errors] if flash[:errors]
  erb :splash
end
