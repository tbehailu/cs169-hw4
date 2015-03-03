require 'spec_helper'

# a model method in the Movie model to find movies whose director matches that of the current movie
describe Movie do
  # pending "add some examples to (or delete) #{__FILE__}"
    describe 'finding matching movies' do

  	movie = Movie.new(:title => 'Example', :release_date => '25-Nov-1992', :rating => 'PG', :description => 'description')
  
  	# movie.should be_a Movie
  	movie.title.should == 'Example'
  	movie.release_date.should == '25-Nov-1992'
  	movie.rating.should == 'PG'
  	movie.description.should == 'description'	
  	movie.director.should == nil


  	# @movies = Movie.similar_movies(params[:movie_id])
    # it 'should call the model method that performs TMDb search'
    # it 'should select the Search Results template for rendering'
    # it 'should make the TMDb search results available to that template'
  end
end