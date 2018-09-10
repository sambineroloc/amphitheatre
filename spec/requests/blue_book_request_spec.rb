require 'rails_helper'

RSpec.describe 'Blue Book requests', :type => :request do

  describe 'GET /blue_books/:id.json' do

    context 'when the request is valid' do
      it "can render a blue_books's information" do
        blue_book = create(:blue_book)
        get "/blue-books/#{blue_book.id}.json"
        hash_body = nil

        expect {hash_body = JSON.parse(response.body).with_indifferent_access}.not_to raise_exception
        expect(hash_body['data']['attributes']).to match_array(
          [
            ['title', blue_book.title],
            ['body', blue_book.body],
            ['reward', blue_book.reward],
          ]
        )
        expect(hash_body['data']['relationships'].keys).to match_array(['chapter', 'character'])
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /blue-books' do
    let(:chapter) { create(:chapter, id: 1) }
    let(:character) { create(:character, id: 1) }

    context 'when the request is valid' do
      it "can create a blue book" do
        chapter
        character
        json_helper = Helpers::JSON.new('blue_book')
        headers = json_helper.json_headers
        successful_post = json_helper.successful_post
        post blue_books_path, params: successful_post, headers: headers
        hash_body = nil
        expect { hash_body = JSON.parse(response.body).with_indifferent_access }.not_to raise_exception
        expect(response.status).to eq(201)
      end
    end
  end
end