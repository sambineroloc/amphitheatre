require 'rails_helper'

RSpec.describe 'Event requests', :type => :request do
  hash_body = nil

  describe 'GET /events/:id.json' do

    context 'when the request is valid' do
      it "can render a event's information" do
        event_a = create(:event)
        event_b = create(:event)
        get "/events.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body['data']
        expect(data.first['attributes']).to match(
          {
            'character-ids': event_a.character_ids,
            'description': event_a.description,
            'location-ids': event_a.location_ids,
            'title': event_a.title
          }
        )
        expect(data.second['attributes']).to match(
          {
            'character-ids': event_b.character_ids,
            'description': event_b.description,
            'location-ids': event_b.location_ids,
            'title': event_b.title
          }
        )
        expect(data.first['relationships'].keys).to match_array(['chapter'])
        expect(data.second['relationships'].keys).to match_array(['chapter'])
        expect(response.status).to eq(200)
      end
    end

    context '/events/:id.json' do
      it 'returns the information of one event' do
        event = create(:event)
        get "/events/#{event.id}.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        expect(hash_body['data']['attributes']).to match(
          {
            'title': event.title,
            'description': event.description,
            'character-ids': event.character_ids,
            'location-ids': event.location_ids
          }
        )
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /events' do
    let(:chapter) { create(:chapter, id: 1) }

    context 'when the request is valid' do

      it "can create a event" do
        chapter
        json_helper = JsonHelper.new('events')
        post events_path,
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
    let(:event) { create(:event, id: 1, title: 'Super cool event', description: 'Wow', character_ids: ['3', '5', '7'], location_ids: ['4', '2', '1']) }
    let(:chapter) { create(:chapter, id: 1) }

    context 'when the request is valid' do
      it 'updates the event' do
        chapter
        event
        json_helper = JsonHelper.new('events')
        put event_path(event),
          params: json_helper.successful_put(event.id),
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body["data"]
        attributes = data["attributes"]
        expect(data["id"]).to eq(event.id.to_s)
        expect(attributes["title"]).to eq(event.title)
        expect(attributes["description"]).to eq(event.description)
        expect(attributes["character-ids"]).to eq(event.character_ids)
        expect(attributes["location-ids"]).to eq(event.location_ids)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE requests' do
    let(:event) { create(:event) }

    context 'when the request is valid' do
      it 'deletes the event' do
        event
        expect(Event.all.length).to eq(1)
        json_helper = JsonHelper.new('events')
        headers = json_helper.json_headers
        delete event_path(event), headers: headers

        expect(Event.all.length).to eq(0)
        expect(response.status).to eq(204)
      end
    end
  end
end
