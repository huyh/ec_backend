module Api
  class TvShowsController < ApplicationController
    def index
      tv_shows = movie_db_service.search_tv_show(params[:query])
      render json: tv_shows
    end

    def add_to_watchlist
      movie_db_service.add_tv_show_to_watchlist(params[:id])
    end

    def remove_from_watchlist
      movie_db_service.remove_tv_show_from_watchlist(params[:id])
    end

    def add_to_favorite
      movie_db_service.add_tv_show_to_favorite(params[:id])
    end

    def remove_from_favorite
      movie_db_service.remove_tv_show_from_favorite(params[:id])
    end

    private

    def movie_db_service
      @service ||= MovieDbService.new
    end
  end
end
