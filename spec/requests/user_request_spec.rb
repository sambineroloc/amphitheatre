require 'rails_helper'

RSpec.describe 'User requests', :type => :request do
  hash_body = nil

  describe 'GET requests to' do
    context '/users/:id.json' do
      it 'returns the information of one user' do
        user = create(:user)
        get "/users/#{user.id}.json"

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        expect(hash_body['data']['attributes']).to match(
          {
            'email': user.email,
            'username': user.username
          }
        )
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /users' do
    context 'when the request is valid' do
      it "can create a user" do
        json_helper = JsonHelper.new('users')
        post users_path,
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
    let(:user) { create(:user, id: 1) }

    context 'when the request is valid' do
      it 'updates the user' do
        json_helper = JsonHelper.new('users')
        put user_path(user),
          params: json_helper.successful_put(user.id),
          headers: json_helper.json_headers

        expect {
          hash_body = JSON.parse(response.body).with_indifferent_access
        }.not_to raise_exception
        data = hash_body["data"]
        attributes = data["attributes"]
        expect(data["id"]).to eq(user.id.to_s)
        expect(attributes["email"]).to eq('email@gmail.com')
        expect(attributes["username"]).to eq('username')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE requests' do
    let(:user) { create(:user) }

    context 'when the request is valid' do
      it 'deletes the user' do
        user
        expect(User.all.length).to eq(1)
        json_helper = JsonHelper.new('users')
        headers = json_helper.json_headers
        delete user_path(user), headers: headers

        expect(User.all.length).to eq(0)
        expect(response.status).to eq(204)
      end
    end
  end
end
