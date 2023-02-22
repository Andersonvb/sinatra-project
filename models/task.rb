# frozen_string_literal: true

require 'json'
require 'net/http'

class Task
  URL = 'https://crudcrud.com/api/42f72cf27c2148788ccdc5df3f3529b5/tasks'

  attr_accessor :id, :content, :completed

  def initialize(params = {})
    @id = params[:id]
    @content = params[:content]
    @completed = params[:completed]
  end

  def save
    uri = URI(URL)
    headers = { 'Content-Type': 'application/json' }
    task = {
      content: content,
      completed: completed
    }

    if id.nil?
      response = Net::HTTP.post(uri, task, headers)
      @id = JSON.parse(response)['_id']
    else
      uri = URI("#{URL}/#{id}")
      Net::HTTP.put(uri, task, headers)
    end
  end

  def self.find(id)
    uri = URI("#{URL}/#{id}")
    response = Net::HTTP.get(uri)

    Task.new(JSON.parse(response))
  end

  def self.all
    uri = URI(URL)
    response = Net::HTTP.get(uri)
    tasks = JSON.parse(response)

    tasks.map { |task| Task.new(task) }
  end

  def destroy
    uri = URI("#{URL}/#{id}")
    response = Net::HTTP.delete(uri)

    response == 204
  end
end
