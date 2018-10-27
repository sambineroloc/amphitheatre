require 'rails_helper'

RSpec.describe 'Character requests', :type => :request do
  hash_body = nil

  describe 'GET requests to' do
    context '/characters.json' do
      it 'returns the information of all characters' do
        character_a = create(:character)
        character_b = create(:character)
        get "/characters.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body['data']
        expect(data.length).to eq(2)
        expect(data.first['attributes']).to match(
          {
            'name': character_a.name,
            'description': character_a.description,
            'pc-class': character_a.pc_class,
            'level': character_a.level
          }
        )
        expect(data.second['attributes']).to match(
          {
            'name': character_b.name,
            'description': character_b.description,
            'pc-class': character_b.pc_class,
            'level': character_b.level
          }
        )
        expect(response.status).to eq(200)
      end

      context '/characters/:id.json' do
        it 'returns the information of one character' do
          character = create(:character)
          get "/characters/#{character.id}.json"

          expect {
            hash_body = JSON.parse(response.body).with_indifferent_access
          }.not_to raise_exception
          expect(hash_body['data']['attributes']).to match(
            {
              'name': character.name,
              'description': character.description,
              'pc-class': character.pc_class,
              'level': character.level
            }
          )
          expect(response.status).to eq(200)
        end
      end
    end

    context '/characters/:id.json' do
      it "renders a characters's information" do
        character = create(:character)
        get "/characters/#{character.id}.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body['data']
        expect(data['attributes']).to match_array(
          [
            ['name', character.name],
            ['description', character.description],
            ['level', character.level],
            ['pc-class', character.pc_class],
          ]
        )
        expect(data['attributes']).to match(
          {
            'name': character.name,
            'description': character.description,
            'pc-class': character.pc_class,
            'level': character.level
          }
        )
        expect(data['relationships'].keys).to match_array(['blue-books', 'campaign', 'user'])
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST requests' do
    let(:campaign) { create(:campaign, id: 1) }
    let(:user) { create(:user, id: 1) }

    context 'when the request is valid' do
      it "can create a character" do
        campaign
        user
        json_helper = JsonHelper.new('characters')
        post characters_path,
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
    let(:character) { create(:character, id: 1, name: 'Bobo', description: 'So brave', pc_class: 'Fighter', level: 3) }
    let(:campaign) { create(:campaign, id: 1) }
    let(:user) { create(:user, id: 1) }

    context 'when the request is valid' do
      it 'updates the character' do
        campaign
        user
        character
        json_helper = JsonHelper.new('characters')
        headers = json_helper.json_headers
        successful_put = json_helper.successful_put(character.id)
        put character_path(character),
          params: json_helper.successful_put(character.id),
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body["data"]
        attributes = data["attributes"]
        expect(data["id"]).to eq(character.id.to_s)
        expect(attributes["name"]).to eq('name')
        expect(attributes["description"]).to eq('description')
        expect(attributes["pc-class"]).to eq('class')
        expect(attributes["level"]).to eq(1)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE requests' do
    let(:character) { create(:character) }

    context 'when the request is valid' do
      it 'deletes the character' do
        character
        expect(Character.all.length).to eq(1)
        json_helper = JsonHelper.new('characters')
        headers = json_helper.json_headers
        delete character_path(character), headers: headers

        expect(Character.all.length).to eq(0)
        expect(response.status).to eq(204)
      end
    end
  end
end
