require 'rails_helper'

RSpec.describe 'Campaign requests', :type => :request do
  hash_body = nil

  describe 'GET /campaigns/:id.json' do

    context 'when the request is valid' do
      it "can render a campaign's information" do
        campaign_a = create(:campaign)
        campaign_b = create(:campaign)
        get "/campaigns.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body['data']
        expect(data.first['attributes']).to match(
          {
            'title': campaign_a.title,
            'description': campaign_a.description,
          }
        )
        expect(data.second['attributes']).to match(
          {
            'title': campaign_b.title,
            'description': campaign_b.description
          }
        )
        expect(data.first['relationships'].keys).to match_array(['user', 'setting-details', 'chapters', 'characters'])
        expect(data.second['relationships'].keys).to match_array(['user', 'setting-details', 'chapters', 'characters'])
        expect(response.status).to eq(200)
      end
    end

    context '/campaigns/:id.json' do
      it 'returns the information of one campaign' do
        campaign = create(:campaign)
        get "/campaigns/#{campaign.id}.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        expect(hash_body['data']['attributes']).to match(
          {
            'title': campaign.title,
            'description': campaign.description
          }
        )
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /campaigns' do
    let(:user) { create(:user, id: 1) }

    context 'when the request is valid' do

      it "can create a campaign" do
        user
        json_helper = JsonHelper.new('campaigns')
        post campaigns_path,
          params: json_helper.successful_post,
          headers: json_helper.json_headers
        hash_body = nil
        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        expect(response.status).to eq(201)
      end
    end
  end

  describe 'PUT requests' do
    let(:campaign) { create(:campaign, id: 1, title: 'Super cool campaign', description: 'Wow') }
    let(:user) { create(:user, id: 1) }

    context 'when the request is valid' do
      it 'updates the campaign' do
        campaign
        user
        json_helper = JsonHelper.new('campaigns')
        put campaign_path(campaign),
          params: json_helper.successful_put(campaign.id),
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body["data"]
        attributes = data["attributes"]
        expect(data["id"]).to eq(campaign.id.to_s)
        expect(attributes["title"]).to eq('title')
        expect(attributes["description"]).to eq('description')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE requests' do
    let(:campaign) { create(:campaign) }

    context 'when the request is valid' do
      it 'deletes the campaign' do
        campaign
        expect(Campaign.all.length).to eq(1)
        json_helper = JsonHelper.new('campaigns')
        headers = json_helper.json_headers
        delete campaign_path(campaign), headers: headers

        expect(Campaign.all.length).to eq(0)
        expect(response.status).to eq(204)
      end
    end
  end
end
