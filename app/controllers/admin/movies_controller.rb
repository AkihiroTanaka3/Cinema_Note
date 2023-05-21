class Admin::MoviesController < ApplicationController
  before_action :authenticate_user_or_admin!

  def index
    # APIのデータを検索して表示する
    if params[:looking_for]
      movie_title = params[:looking_for]
      movies = []
      (1..5).each do |page|
        url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API']}&language=ja&query=" + URI.encode_www_form_component(movie_title) + "&page=#{page}"
        response = Net::HTTP.get_response(URI.parse(url))
        if response.code == "200"
          result = JSON.parse(response.body)
          movies.concat(result["results"])
        end
      end
    else
      movies = []
      (1..5).each do |page|
        url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API']}&language=ja&page=#{page}"
        response = Net::HTTP.get_response(URI.parse(url))
        if response.code == "200"
          result = JSON.parse(response.body)
          movies.concat(result["results"])
        end
      end
    end
    @movies = Kaminari.paginate_array(movies).page(params[:page]).per(20)
  end

  def show
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

  def create
    # APIからデータを直接カラムに保存する
    movie = params[:movie]
    Movie.new(
      name: movie['title'],
      year: movie['release_date'],
      genre_name: movie["genres"][0]["name"],
      image: movie['poster_path'],
      overview: movie['overview'],
      runtime: movie['runtime'],
      )
      .save
      redirect_to admin_movies_path
  end
  
  def authenticate_user_or_admin!
    request.path.start_with?('/admin')
    authenticate_admin!
  end
  
end