# frozen_string_literal: true

require 'json'
require 'net/http'
require 'httparty'

class Task
  # BASE_URL = 'https://crudcrud.com/api/3d438503e4ab47c48178da26a34a3aea/tasks'
  BASE_URL = ''
  HEADERS = {
    'Content-Type' => 'application/json',
    'Accept' => 'application/json'
  }

  attr_accessor :id, :content, :completed

  def initialize(params = {})
    @id = params['_id']
    @content = params['content']
    @completed = params['completed']
  end

  def save
    task = {
      content: @content,
      completed: @completed
    }.to_json

    HTTParty.post("#{BASE_URL}", headers: HEADERS, body: task)
  end

  def destroy
    HTTParty.delete("#{BASE_URL}/#{@id}", headers: HEADERS)
  end

  def self.all
    response = HTTParty.get("#{BASE_URL}", headers: HEADERS)

    response.map { |task_params| Task.new(task_params) }
  end

  def self.find(id)
    task_params = HTTParty.get("#{BASE_URL}/#{id}", headers: HEADERS)

    Task.new(task_params)
  end
end
