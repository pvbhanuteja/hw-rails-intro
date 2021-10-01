class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      # @movies = Movie.all
      @all_ratings = Movie.ratings
      # @ratings_hash = @all_ratings.map {|key| [key, 1]}.to_h
      # sort = params[:sort]
      # if (params[:ratings] != nil)
      # @ratings_hash = params[:ratings]
      # @movies = @movies.where(:rating => @ratings_hash.keys)
      # session[:ratings] = @ratings_hash
      # end
      # # p params
      # p @ratings_hash
      # case sort
      # when 'title'
      #   @title_class = 'bg_highlight'
      #   @movies = Movie.order('title ASC')
      # when 'release_date'
      #   @release_date_class =  'bg_highlight'
      #   @movies = Movie.order('release_date ASC')
      # end
      if (params[:ratings] != nil)
        session[:ratings] = params[:ratings]
      end
      if (params[:sort] != nil)
        session[:sort] = params[:sort]
      end
      
      if (params[:ratings] == nil && session[:ratings] != nil) || (params[:sort] == nil && session[:sort] != nil)
        redirect_to movies_path("sort" => session[:sort], "ratings" => session[:ratings])
      elsif params[:ratings] != nil || params[:sort] != nil
        if params[:ratings] == nil
          return @movies = Movie.all.order(session[:sort])
        else
          array_ratings = params[:ratings].keys
          return @movies = Movie.where(rating: array_ratings).order(session[:sort])
        end
      elsif session[:ratings] != nil || session[:sort] != nil
        redirect_to movies_path("ratings" => session[:ratings], "sort" => session[:sort])
      else
        return @movies = Movie.all
      end
      
    end
  
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      flash.keep
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      flash.keep
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      flash.keep
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end