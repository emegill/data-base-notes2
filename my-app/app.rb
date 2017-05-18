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

post '/sign_up' do
	@user = params[:username]
	@password = params[:password]
	new_user = User.create(username: @user, password: @password)
	session[:user_id] = new_user.id
	redirect '/profile'
end

get '/content' do
	user = User.find(session[:user_id])
	@blogpost = user.blogs.where(title: params[:title]).first
	erb :content
end

# post '/comment' do
# 	@comment = Comment.find(params[:comment_id])
# 	# comment = Blog.find()
# 	# Comment.create(comment: @comment)
# 	# redirect '/content'
# end


