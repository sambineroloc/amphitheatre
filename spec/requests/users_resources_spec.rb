require 'rails_helper'

RSpec.describe 'User resources', :type => :request do

  it "can render a user's information" do
    user = create(:user)
    get "/users/#{user.id}.json"
    hash_body = nil
      expect {
        hash_body = JSON.parse(response.body).with_indifferent_access
      }.not_to raise_exception
      expect(hash_body['data']['attributes']).to match_array([["email", user.email], ["username", user.username]])
      expect(hash_body['data']['attributes']).to match({
        'username': user.username,
        'email': user.email
      })
  end
end
