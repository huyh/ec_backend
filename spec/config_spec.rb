require 'rails_helper'

describe 'application config' do
  it 'has the config for themoviedb API key' do
    expect(Rails.application.config.themoviedb_api_key).to eq('c93d80607200d97f147998401cb86183')
  end

  it 'has the config for themoviedb session id' do
    expect(Rails.application.config.themoviedb_session_id).to eq('4dcf57d905ceaf6499e19e97bb3076b71982179e')
  end
end
