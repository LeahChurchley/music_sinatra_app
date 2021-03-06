helpers do

  def current_user
    if session[:id]
      User.find(session[:id])
    end
  end

end


# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )
  @song.user_id = current_user.id if current_user
  if current_user && @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/songs/:id' do 
  @song = Song.find params[:id]
  erb :'songs/show'
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.new(
    name: params[:name],
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    redirect '/'
  else
    erb :'users/new'
  end
end

get '/login' do
  erb :'login'
end

post '/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    session[:id] = @user.id
    redirect '/'
  else
    erb :'login'
  end  
end

get '/logout' do
  session[:id] = nil
  redirect '/'
end
