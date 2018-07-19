require 'rails_helper'

describe 'application config' do
  it 'has the config for themoviedb API key' do
    expect(Rails.application.config.themoviedb_api_key).to eq('c93d80607200d97f147998401cb86183')
  end
end
