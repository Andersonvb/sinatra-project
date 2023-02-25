# frozen_string_literal: true

require 'sinatra'
require_relative './models/task'

# Index
get '/' do
  @tasks = Task.all
  erb :index
end

# Create
post '/tasks' do
  task = Task.new({ 'content' => params[:content], 'completed' => false })
  task.save
  redirect '/'
end

# Delete
get '/delete/:id' do
  @task = Task.find(params[:id])
  erb :'tasks/delete'
end

post '/tasks/:id' do
  task = Task.find(params[:id])
  task.destroy
  redirect '/'
end
