require 'sinatra'
require 'pry'
require 'csv'

def read_movies_csv(csv)
  all_movies = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    all_movies << row
  end
  all_movies
end


get '/' do
  "Hello Index"
end

get '/movies' do
  @all_movies = read_movies_csv('movies.csv')
  binding.pry
  "Hello Movies"
end
