# frozen_string_literal: true

require 'sinatra'
require_relative './models/task'

# Index
get '/' do
  # TODO: Eliminar este comentario cuando tenga una nueva key
  # @tasks = Task.all
  @tasks = [
    Task.new({'id' => '12345', 'content' => 'This is a task', 'completed' => true}),
    Task.new({'id' => '123456', 'content' => 'This is another task', 'completed' => false}),
    Task.new({'id' => '123457', 'content' => 'This is another task', 'completed' => false}),
  ]
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

# Complete task
get '/complete/:id' do
  task = Task.find(params[:id])
  if task.completed
    task.update(task.id, task.content, false)
  else
    task.update(task.id, task.content, true)
  end
  redirect '/'
end
