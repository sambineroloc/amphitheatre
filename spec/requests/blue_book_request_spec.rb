require 'rails_helper'

RSpec.describe 'Blue Book requests', :type => :request do
  hash_body = nil

  describe 'GET requests to' do
    context '/blue-books.json' do
      it "returns the information of all blue books" do
        blue_book_a = create(:blue_book)
        blue_book_b = create(:blue_book)
        get "/blue-books.json"

        expect {hash_body = JSON.parse(response.body).with_indifferent_access}.not_to raise_exception
        data = hash_body['data']
        expect(data.first['attributes']).to match(
          {
            'title': blue_book_a.title,
            'body': blue_book_a.body,
            'reward': blue_book_a.reward,
          }
        )
        expect(data.second['attributes']).to match(
          {
            'title': blue_book_b.title,
            'body': blue_book_b.body,
            'reward': blue_book_b.reward,
          }
        )
        expect(data.first['relationships'].keys).to match_array(['chapter', 'character'])
        expect(data.second['relationships'].keys).to match_array(['chapter', 'character'])
        expect(response.status).to eq(200)
      end
    end

    context '/blue-books/:id.json' do
      it 'returns the information of one blue book' do
        blue_book = create(:blue_book)
        get "/blue-books/#{blue_book.id}.json"

        expect { hash_body = JSON.parse(response.body).with_indifferent_access }.not_to raise_exception
        expect(hash_body['data']['attributes']).to match(
          {
            'title': blue_book.title,
            'body': blue_book.body,
            'reward': blue_book.reward,
          }
        )
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
        json_helper = JsonHelper.new('blue_books')
        post blue_books_path,
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
    let(:blue_book) { create(:blue_book, id: 1, title: 'Super cool blue book', body: 'Wow', reward: 'What a nice reward') }
    let(:chapter) { create(:chapter, id: 1) }
    let(:character) { create(:character, id: 1) }

    context 'when the request is valid' do
      it 'updates the blue book' do
        chapter
        character
        blue_book
        json_helper = JsonHelper.new('blue_books')
        put blue_book_path(blue_book),
          params: json_helper.successful_put(blue_book.id),
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body["data"]
        attributes = data["attributes"]
        expect(data["id"]).to eq(blue_book.id.to_s)
        expect(attributes["title"]).to eq('title')
        expect(attributes["body"]).to eq('body')
        expect(attributes["reward"]).to eq('reward')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE requests' do
    let(:blue_book) { create(:blue_book) }

    context 'when the request is valid' do
      it 'deletes the blue book' do
        blue_book
        expect(BlueBook.all.length).to eq(1)
        json_helper = JsonHelper.new('blue_books')
        headers = json_helper.json_headers
        delete blue_book_path(blue_book), headers: headers

        expect(BlueBook.all.length).to eq(0)
        expect(response.status).to eq(204)
      end
    end
  end
end
