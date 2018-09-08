require 'rails_helper'

RSpec.describe 'Character requests', :type => :request do

  describe 'GET /characters/:id.json' do

    context 'when the request is valid' do
      it "can render a characters's information" do
        character = create(:character)
        get "/characters/#{character.id}.json"
        hash_body = nil

        expect {hash_body = JSON.parse(response.body).with_indifferent_access}.not_to raise_exception
        expect(hash_body['data']['attributes']).to match_array(
          [
            ['name', character.name],
            ['description', character.description],
            ['level', character.level],
            ['pc-class', character.pc_class],
          ]
        )
        expect(hash_body['data']['attributes']).to match(
          {
            'name': character.name,
            'description': character.description,
            'pc-class': character.pc_class,
            'level': character.level
          }
        )
        expect(hash_body['data']['relationships'].keys).to match_array(['blue-books', 'campaign', 'user'])
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /characters' do
    let(:campaign) { create(:campaign, id: 1) }
    let(:user) { create(:user, id: 1) }

    context 'when the request is valid' do
      it "can create a characters" do
        campaign
        user
        json_helper = Helpers::JSON.new('character')
        headers = json_helper.json_headers
        successful_post = json_helper.successful_post
        post characters_path, params: successful_post, headers: headers
        hash_body = nil
        expect { hash_body = JSON.parse(response.body).with_indifferent_access }.not_to raise_exception
        expect(response.status).to eq(201)
      end
    end
  end
end