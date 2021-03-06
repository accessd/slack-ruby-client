require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Users do
  let(:client) { Slack::Web::Client.new }
  context 'users' do
    it 'list', vcr: { cassette_name: 'web/users_list' } do
      json = client.users_list(presence: true)
      expect(json['ok']).to be true
      expect(json['members'].size).to eq 9
      expect(json['members'].first['presence']).to eq 'away'
    end
    it 'info', vcr: { cassette_name: 'web/users_info' } do
      json = client.users_info(user: '@aws')
      expect(json['user']['name']).to eq 'aws'
    end
    it 'search', vcr: { cassette_name: 'web/users_info' } do
      json = client.users_search(user: 'aws')
      expect(json['ok']).to be true
      expect(json['members'].size).to eq 1
      expect(json['members'].first['name']).to eq 'aws'
    end if defined?(Picky)
  end
end
