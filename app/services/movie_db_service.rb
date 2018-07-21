require 'rest-client'

class MovieDbService
  API_BASE_URL = 'https://api.themoviedb.org/3'

  def search_tv_show(query)
    return [] unless query.present?
    url = "#{API_BASE_URL}/search/tv"
    response = RestClient.get(url, {
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        query: query
      }
    })
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def get_tv_show_watchlist
    url = "#{API_BASE_URL}/account/-1/watchlist/tv"
    response = RestClient.get(url, {
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id
      }
    })
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def get_favorite_tv_shows
    url = "#{API_BASE_URL}/account/-1/favorite/tv"
    response = RestClient.get(url, {
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id
      }
    })
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def add_tv_show_to_watchlist(tv_show_id)
    add_or_remove_tv_show_on_watchlist(tv_show_id: tv_show_id, add_to_watchlist: true)
  end

  def remove_tv_show_from_watchlist(tv_show_id)
    add_or_remove_tv_show_on_watchlist(tv_show_id: tv_show_id, add_to_watchlist: false)
  end

  def add_tv_show_to_favorite(tv_show_id)
    add_or_remove_tv_show_on_favorite(tv_show_id: tv_show_id, add_to_favorite: true)
  end

  def remove_tv_show_from_favorite(tv_show_id)
    add_or_remove_tv_show_on_favorite(tv_show_id: tv_show_id, add_to_favorite: false)
  end

  private

  def add_or_remove_tv_show_on_watchlist(tv_show_id:, add_to_watchlist:)
    url = "#{API_BASE_URL}/account/-1/watchlist"
    response = RestClient.post(
      url,
      { media_type: 'tv', media_id: tv_show_id, watchlist: add_to_watchlist }.to_json,
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id,
      },
      content_type: :json
    )
    JSON.parse(response.body, symbolize_names: true)
  end

  def add_or_remove_tv_show_on_favorite(tv_show_id:, add_to_favorite:)
    url = "#{API_BASE_URL}/account/-1/favorite"
    response = RestClient.post(
      url,
      { media_type: 'tv', media_id: tv_show_id, favorite: add_to_favorite }.to_json,
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id,
      },
      content_type: :json
    )
    JSON.parse(response.body, symbolize_names: true)
  end
end
