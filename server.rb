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

all_movies = read_movies_csv('movies.csv').sort_by { |row| row[:title] }

get '/' do
  "Hello Index"
end

get '/movies' do
  @all_movies = all_movies
  erb :movies
end

get '/movies/:movie_id' do
  @movie_id = params[:movie_id]
  @movie = all_movies.select { |movie| movie[:id] == @movie_id }
  binding.pry
  erb :movie
end
