require 'rails_helper'

module Api
  describe TvShowsController, type: :request do
    describe 'GET /api/tv_shows' do
      it 'return matching TV shows' do
        expect_any_instance_of(MovieDbService).to receive(:search_tv_show).with('a search term').and_return([ {id: 123}, {id: 789} ])

        get '/api/tv_shows', params: { query: 'a search term' }

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[0][:id]).to eq(123)
        expect(json[1][:id]).to eq(789)
      end
    end

    describe 'POST /api/tv_shows/123/add_to_watchlist' do
      it 'add a TV show to watchlist' do
        expect_any_instance_of(MovieDbService).to receive(:add_tv_show_to_watchlist).with("123")

        post '/api/tv_shows/123/add_to_watchlist'

        expect(response).to have_http_status(204)
      end
    end

    describe 'POST /api/tv_shows/123/remove_from_watchlist' do
      it 'remove a TV show from watchlist' do
        expect_any_instance_of(MovieDbService).to receive(:remove_tv_show_from_watchlist).with("123")

        post '/api/tv_shows/123/remove_from_watchlist'

        expect(response).to have_http_status(204)
      end
    end

    describe 'POST /api/tv_shows/123/add_to_favorite' do
      it 'add a TV show to favorite' do
        expect_any_instance_of(MovieDbService).to receive(:add_tv_show_to_favorite).with("123")

        post '/api/tv_shows/123/add_to_favorite'

        expect(response).to have_http_status(204)
      end
    end

    describe 'POST /api/tv_shows/123/remove_from_favorite' do
      it 'remove a TV show from favorite' do
        expect_any_instance_of(MovieDbService).to receive(:remove_tv_show_from_favorite).with("123")

        post '/api/tv_shows/123/remove_from_favorite'

        expect(response).to have_http_status(204)
      end
    end
  end
end
