require 'rails_helper'

describe MovieDbService do
  let(:service) { MovieDbService.new }

  let(:response_body) {
    <<-JSON
      {
          "page": 1,
          "results": [
              {
                  "backdrop_path": "/nGsNruW3W27V6r4gkyc3iiEGsKR.jpg",
                  "first_air_date": "2007-09-24",
                  "genre_ids": [
                      35
                  ],
                  "id": 1418,
                  "original_language": "en",
                  "original_name": "The Big Bang Theory",
                  "overview": "The Big Bang Theory is centered on five characters living in Pasadena, California: roommates Leonard Hofstadter and Sheldon Cooper; Penny, a waitress and aspiring actress who lives across the hall; and Leonard and Sheldon's equally geeky and socially awkward friends and co-workers, mechanical engineer Howard Wolowitz and astrophysicist Raj Koothrappali. The geekiness and intellect of the four guys is contrasted for comic effect with Penny's social skills and common sense.",
                  "origin_country": [
                      "US"
                  ],
                  "poster_path": "/ooBGRQBdbGzBxAVfExiO8r7kloA.jpg",
                  "popularity": 274.311,
                  "name": "The Big Bang Theory",
                  "vote_average": 6.8,
                  "vote_count": 3081
              }
          ],
          "total_pages": 1,
          "total_results": 1
      }
    JSON
  }

  let(:raw_response) { double(:response, body: response_body) }

  it 'search tv shows' do
    expect(RestClient).to receive(:get).with(
      'https://api.themoviedb.org/3/search/tv',
      {
        params: {
          api_key: Rails.application.config.themoviedb_api_key,
          query: 'hello'
        }
      }
    ).and_return(raw_response)

    results = service.search_tv_show('hello')

    expect(results.size).to eq(1)
    expect(results[0][:id]).to eq(1418)
  end

  it 'get tv show watchlist' do
    expect(RestClient).to receive(:get).with(
      'https://api.themoviedb.org/3/account/-1/watchlist/tv',
      {
        params: {
          api_key: Rails.application.config.themoviedb_api_key,
          session_id: Rails.application.config.themoviedb_session_id
        }
      }
    ).and_return(raw_response)

    results = service.get_tv_show_watchlist

    expect(results.size).to eq(1)
    expect(results[0][:id]).to eq(1418)
  end

  it 'get favorite tv show' do
    expect(RestClient).to receive(:get).with(
      'https://api.themoviedb.org/3/account/-1/favorite/tv',
      {
        params: {
          api_key: Rails.application.config.themoviedb_api_key,
          session_id: Rails.application.config.themoviedb_session_id
        }
       }
    ).and_return(raw_response)

    results = service.get_favorite_tv_shows

    expect(results.size).to eq(1)
    expect(results[0][:id]).to eq(1418)
  end

  it 'add a tv show to watchlist' do
    add_response = double(:response, body: '{"status_code": 1, "status_message": "Success."}')
    expect(RestClient).to receive(:post).with(
      'https://api.themoviedb.org/3/account/-1/watchlist',
      { media_type: 'tv', media_id: 123, watchlist: true }.to_json,
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id
      },
      content_type: :json
    ).and_return(add_response)

    response = service.add_tv_show_to_watchlist(123)

    expect(response[:status_code]).to eq(1)
    expect(response[:status_message]).to eq('Success.')
  end

  it 'remove a tv show from watchlist' do
    remove_response = double(:response, body: '{"status_code": 13, "status_message": "The item/record was deleted successfully."}')
    expect(RestClient).to receive(:post).with(
      'https://api.themoviedb.org/3/account/-1/watchlist',
      { media_type: 'tv', media_id: 123, watchlist: false }.to_json,
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id
      },
      content_type: :json
    ).and_return(remove_response)

    response = service.remove_tv_show_from_watchlist(123)

    expect(response[:status_code]).to eq(13)
    expect(response[:status_message]).to eq('The item/record was deleted successfully.')
  end

  it 'add a tv show to favorite' do
    add_response = double(:response, body: '{"status_code": 1, "status_message": "Success."}')
    expect(RestClient).to receive(:post).with(
      'https://api.themoviedb.org/3/account/-1/favorite',
      { media_type: 'tv', media_id: 123, favorite: true }.to_json,
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id
      },
      content_type: :json
    ).and_return(add_response)

    response = service.add_tv_show_to_favorite(123)

    expect(response[:status_code]).to eq(1)
    expect(response[:status_message]).to eq('Success.')
  end

  it 'remove a tv show from favorite' do
    remove_response = double(:response, body: '{"status_code": 13, "status_message": "The item/record was deleted successfully."}')
    expect(RestClient).to receive(:post).with(
      'https://api.themoviedb.org/3/account/-1/favorite',
      { media_type: 'tv', media_id: 123, favorite: false }.to_json,
      params: {
        api_key: Rails.application.config.themoviedb_api_key,
        session_id: Rails.application.config.themoviedb_session_id
      },
      content_type: :json
    ).and_return(remove_response)

    response = service.remove_tv_show_from_favorite(123)

    expect(response[:status_code]).to eq(13)
    expect(response[:status_message]).to eq('The item/record was deleted successfully.')
  end
end
