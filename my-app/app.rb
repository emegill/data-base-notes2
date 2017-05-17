require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:app.sqlite3'
set :sessions, true

require './models'

get '/' do
	erb :login
end

post '/login' do
	user = User.where(username: params[:username]).first
	if user.password == params[:password]
		session[:user_id] = user.id
		redirect '/profile'
	else
		redirect '/'
	end
end

get '/profile' do
	@user = User.find(session[:user_id])
	@blogs = @user.blogs
	erb :index
end

post '/profile' do
	user = User.find(session[:user_id])
	title_from_params = params[:title]
	content_from_params = params[:content]
	Blog.create(title: title_from_params, content: content_from_params, user_id: user.id)
	redirect '/profile'
end
