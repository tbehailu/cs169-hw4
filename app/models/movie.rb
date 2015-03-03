class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date, :director

  def self.similar_movies(movie_id)
    puts "made call to similar controller method"
    movie = Movie.find(movie_id)
    director = movie.director
    puts "director = ", director, director == ""
    if director == ""
      return ""
    else
      return Movie.find(:all, :conditions => ["director LIKE ?", director])
    end
  end
end