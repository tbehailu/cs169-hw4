require 'spec_helper'

# a RESTful route for Find Similar Movies (HINT: use the 'match' syntax for routes as suggested in "Non-Resource-Based Routes" in Section 4.1 of ESaaS)

describe MoviesController do
  describe "RESTful routing for Find Similar Movies" do
  	# before :each do
  	# 	@movie = Movie.create(:id => "1", :title => "Example")
  	# 	@movie2 = Movie.create(:id => "2", :title => "Example2")
  	# end
  	it {
  		@movie = Movie.create(:title => "Example")
  		expect(:get => "/movies/1/similar").to route_to(
  		:action => "similar",
  		:controller => "movies",
  		:movie_id => "1")
  	}
  	it {
  		@movie = Movie.create(:title => "Example")
  		expect(:get => "/movies/#{@movie.id}/similar").to route_to(
  		:action => "similar",
  		:controller => "movies",
  		:movie_id => "1")
  	}
  	it {
  		@movie = Movie.create(:title => "Example")
  		expect(:get => "/movies/#{@movie.id}/edit").to route_to(
  		:action => "edit",
  		:controller => "movies",
  		:id => "1")
  	}
  	it {
  		@movie = Movie.create(:id => "1", :title => "Example")
  		expect(:get => "/movies").to route_to(
  		:action => "index",
  		:controller => "movies")
  	}
  	it {
  		expect(:get => "/movies/new").to route_to(
  		:action => "new",
  		:controller => "movies")
  	}
  	it {
  		expect(:get => "/movies/new").to route_to(
  		:action => "new",
  		:controller => "movies")
  	}
  	it {
  	  # @movie = Movie.create(:title => "Example", :director => "")
      post :create, :movie => {:title => "Example"}
      response.should_not be_successful
  	}
  	it {
  	  @movie = Movie.create(:title => 'Example', :release_date => '25-Nov-1992', :rating => 'PG', :description => 'description')
  	  delete :destroy, {:id => "1"}
  	  # Movie.should_receive(:find_by_id).with("1")
      response.should_not be_successful
  	}
   end


# a controller method to receive the click on "Find With Same Director", and grab the id (for example) of the movie that is the subject of the match (i.e. the one we're trying to find movies similar to)
  describe 'finding Similar Movies' do
  	# before :each do
  	# 	@movie = Movie.create(:id => "1", :title => "Example")
  	# end
    it 'should call the model method that gets Similar Movies' do
      # results = [mock('1')]
      @movie = Movie.create(:id => "1", :title => "Example")
      Movie.should_receive(:similar_movies).with('1').and_return(@movie)
      get :similar, {:movie_id => @movie.id}
    end
    it 'should select the similar movies template for rendering' do
      @movie = Movie.create(:id => "1", :title => "Example")
      Movie.should_receive(:similar_movies).with('1').and_return(@movie)
      get :similar, {:movie_id => @movie.id}
      response.should be_successful
      response.should render_template("similar")
	end
    # it 'should make the TMDb search results available to that template'
  end
end
