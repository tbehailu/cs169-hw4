class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def similar
    id = params[:movie_id] # retrieve movie ID from URI route
    puts "made call to similar controller method"
    movie = Movie.find(id)
    # director = Movie.find(id).director
    # puts "director = ", director, director == ""
    # if director == ""
    #   # flash[:notice] = "#{movie.title}' has no director info" 
    #   redirect_to movies_path, notice: "'#{movie.title}' has no director info" 
    # else
    #   @movies = Movie.find(:all, :conditions => ["director LIKE ?", director], :order => session[:sort_var])
    #   puts "directing to similar directors page"
    # end
    movies = Movie.similar_movies(id)
    if movie.director == ""
      flash[:notice] = "#{movie.title}' has no director info"
      redirect_to movies_path, notice: "'#{movie.title}' has no director info" 
    else
      # @movies = Movie.find(:all, director: movie.director, :order => session[:sort_var])
      @movies = Movie.find(:all, :conditions => ["director LIKE ?", movie.director], :order => session[:sort_var])
    end
  end

  def get_ratings()
    @ratings = params[:ratings]
    @ratings_checked = {} 
    # if we have ratings selected, get them and set the others as unselected
    if !@ratings.nil?
      if (!@ratings.kind_of? Array) # first time
        # session[:original_ratings] = @ratings
        @ratings = @ratings.keys()
      end
      session[:ratings] = @ratings
      check_ratings()
    else

      if session[:ratings].nil?
        session[:ratings] = @all_ratings
      end

      @redirect_hash[:ratings] = session[:ratings]
      params[:ratings] = session[:ratings]
      @redirect = true

    end
  end

  def check_ratings()
    @all_ratings.each do |r|
      if (!@ratings.include? r)
        @ratings_checked[r] = false
      else
        @ratings_checked[r] = true
      end
    end
    session[:ratings_checked] = @ratings_checked
  end

  def index
    @all_ratings = Movie.uniq.pluck(:rating)
    @redirect = false
    @redirect_hash = {}

    get_ratings()

    if (!params[:sort_var].nil?)
      session[:sort_var] = params[:sort_var]
      @sort_var = session[:sort_var]
      @movies = Movie.find(:all, :conditions => ["rating IN (?)", session[:ratings]], :order => session[:sort_var])
    else
      if !session[:sort_var].nil?
        @redirect_hash[:sort_var] = session[:sort_var]
        params[:sort_var] = session[:sort_var]
        @redirect = true
      else
        @movies = Movie.find(:all, :conditions => ["rating IN (?)", session[:ratings]])
      end
    end

    if @redirect
      flash.keep
      redirect_to movies_path(params)
      return
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
    puts "edit controller method"
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end