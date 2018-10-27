require 'rails_helper'

RSpec.describe 'Chapter requests', :type => :request do
  hash_body = nil

  describe 'GET requests to' do
    context '/chapters.json' do
      it "returns the information of all chapters" do
        chapter_a = create(:chapter)
        chapter_b = create(:chapter)
        get "/chapters.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body['data']
        expect(data.first['attributes']).to match(
          {
            'title': chapter_a.title,
            'description': chapter_a.description,
          }
        )
        expect(data.second['attributes']).to match(
          {
            'title': chapter_b.title,
            'description': chapter_b.description
          }
        )
        expect(data.first['relationships'].keys).to match_array(["blue-books", "campaign"])
        expect(data.second['relationships'].keys).to match_array(["blue-books", "campaign"])
        expect(response.status).to eq(200)
      end
    end

    context '/chapters/:id.json' do
      it 'returns the information of one chapter' do
        chapter = create(:chapter)
        get "/chapters/#{chapter.id}.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        expect(hash_body['data']['attributes']).to match(
          {
            'title': chapter.title,
            'description': chapter.description
          }
        )
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /chapters' do
    let(:campaign) { create(:campaign, id: 1) }

    context 'when the request is valid' do
      it "can create a chapter" do
        campaign
        json_helper = JsonHelper.new('chapters')
        post chapters_path,
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
    let(:chapter) { create(:chapter, id: 1, title: 'Super cool chapter', description: 'Wow') }
    let(:campaign) { create(:campaign, id: 1) }

    context 'when the request is valid' do
      it 'updates the chapter' do
        campaign
        chapter
        json_helper = JsonHelper.new('chapters')
        put chapter_path(chapter),
          params: json_helper.successful_put(chapter.id),
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body["data"]
        attributes = data["attributes"]
        expect(data["id"]).to eq(chapter.id.to_s)
        expect(attributes["title"]).to eq('title')
        expect(attributes["description"]).to eq('description')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE requests' do
    let(:chapter) { create(:chapter) }

    context 'when the request is valid' do
      it 'deletes the chapter' do
        chapter
        expect(Chapter.all.length).to eq(1)
        json_helper = JsonHelper.new('chapters')
        headers = json_helper.json_headers
        delete chapter_path(chapter), headers: headers

        expect(Chapter.all.length).to eq(0)
        expect(response.status).to eq(204)
      end
    end
  end
end
