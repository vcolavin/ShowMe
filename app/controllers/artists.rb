post '/artists' do
  artist = Artist.new(name: params[:name])
  if artist.save
    User.find(params[:user_id]).artists << artist
    return 201, {"name" => artist.name,"id" => artist.id}.to_json
  else
    return 400, "failed validation"
  end
end


delete '/artists/:artist_id' do
  Artist.find(params[:artist_id]).delete
  return 204
end
