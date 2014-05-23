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

def pagination(model, page, offset)
  if page == 1
    model = model[offset..offset + 20]
  else
    model = model[offset + 1..offset + 20]
  end
end

all_movies = read_movies_csv('movies.csv').sort_by { |row| row[:title] }

get '/' do
  "Hello Index"
end

get '/movies' do
  @page = params[:page] || 1
  @page = @page.to_i
  offset = ((@page - 1) * 20)
  @all_movies = pagination(all_movies, @page, offset)
  erb :movies
end

get '/movies/:movie_id' do
  @movie_id = params[:movie_id]
  @movie = all_movies.select { |movie| movie[:id] == @movie_id }
  erb :movie
end
