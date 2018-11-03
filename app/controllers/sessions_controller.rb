# This controls the population of a user within the currentUser service (Stage)
class SessionsController < ActionController::Base
  include HTTParty

  def me
    access_token = params[:access_token]
    return unless access_token

    # TODO: use an env variable that switches for prod instead of this
    base_uri = 'http://localhost:3000/'
    response = HTTParty.get(base_uri + 'oauth/token/info',
                            query: { access_token: access_token })
    user_id = response['resource_owner_id']
    user = HTTParty.get(base_uri + "users/#{user_id}")
    render json: user
  end
end
