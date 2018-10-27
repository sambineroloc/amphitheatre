require 'rails_helper'

RSpec.describe 'Setting Detail requests', :type => :request do
  hash_body = nil

  describe 'GET requests to' do
    context '/setting-details.json' do
      it "returns the information of all setting details" do
        setting_detail_a = create(:setting_detail)
        setting_detail_b = create(:setting_detail)
        get "/setting-details.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body['data']
        expect(data.first['attributes']).to match(
          {
            'title': setting_detail_a.title,
            'description': setting_detail_a.description,
          }
        )
        expect(data.second['attributes']).to match(
          {
            'title': setting_detail_b.title,
            'description': setting_detail_b.description
          }
        )
        expect(data.first['relationships'].keys).to match_array(['campaign'])
        expect(data.second['relationships'].keys).to match_array(['campaign'])
        expect(response.status).to eq(200)
      end
    end

    context '/setting-details/:id.json' do
      it 'returns the information of one setting detail' do
        setting_detail = create(:setting_detail)
        get "/setting-details/#{setting_detail.id}.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        expect(hash_body['data']['attributes']).to match(
          {
            'title': setting_detail.title,
            'description': setting_detail.description
          }
        )
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /setting-details' do
    let(:campaign) { create(:campaign, id: 1) }

    context 'when the request is valid' do
      it "can create a setting detail" do
        campaign
        json_helper = JsonHelper.new('setting_details')
        post setting_details_path,
          params: json_helper.successful_post,
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        expect(response.status).to eq(201)
      end
    end
  end

  describe 'PUT requests' do
    let(:setting_detail) { create(:setting_detail, id: 1, title: 'Location', description: 'Crazyplace') }
    let(:campaign) { create(:campaign, id: 1) }

    context 'when the request is valid' do
      it 'updates the chapter' do
        campaign
        setting_detail
        json_helper = JsonHelper.new('setting_details')
        put setting_detail_path(setting_detail),
          params: json_helper.successful_put(setting_detail.id),
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body["data"]
        attributes = data["attributes"]
        expect(data["id"]).to eq(setting_detail.id.to_s)
        expect(attributes["title"]).to eq('title')
        expect(attributes["description"]).to eq('description')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE requests' do
    let(:setting_detail) { create(:setting_detail) }

    context 'when the request is valid' do
      it 'deletes the setting detail' do
        setting_detail
        expect(SettingDetail.all.length).to eq(1)
        json_helper = JsonHelper.new('setting_details')
        headers = json_helper.json_headers
        delete setting_detail_path(setting_detail), headers: headers

        expect(SettingDetail.all.length).to eq(0)
        expect(response.status).to eq(204)
      end
    end
  end
end
