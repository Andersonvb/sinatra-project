# frozen_string_literal: true

require 'json'
require 'net/http'

class Task
  BASE_URL = 'https://crudcrud.com/api/71313388b24a495abc280a6e55de854c/tasks'

  attr_accessor :id, :content, :completed

  def initialize(params = {})
    @id = params['_id']
    @content = params['content']
    @completed = params['completed']
  end

  def save
    uri = URI(BASE_URL)
    headers = { 'Content-Type': 'application/json' }
    task = {
      content: content,
      completed: completed
    }.to_json

    if id.nil?
      response = Net::HTTP.post(uri, task, headers)
      @id = JSON.parse(response.body)['_id']
    else
      uri = URI("#{BASE_URL}/#{id}")
      Net::HTTP.put(uri, task, headers)
    end
  end

  def self.find(id)
    uri = URI("#{BASE_URL}/#{id}")
    response = Net::HTTP.get(uri)

    Task.new(JSON.parse(response))
  end

  def self.all
    uri = URI(BASE_URL)
    response = Net::HTTP.get(uri)
    tasks = JSON.parse(response)

    tasks.map { |task| Task.new(task) }
  end

  # TODO: Arreglar este bug, no elimina esa cosa
  def destroy
    uri = URI("#{BASE_URL}/#{id}")
    request = Net::HTTP::Delete.new(uri)

    # Se usa Net::HTTP.start para enviar la solicitud a traves de HTTP
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end 

    puts "RESPONSEEEEEE #{response}" 
  end
end
