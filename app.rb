# frozen_string_literal: true

require 'sinatra'
require_relative './models/task'

get '/' do
  @tasks = Task.all
  #@tasks = []
  erb :index
end

post '/' do
  task = Task.new({ content: params[:content], completed: false })
  task.save
  redirect '/'
end
