require 'rails_helper'

describe 'Users API' do
  let(:user) { create(:user, :with_messages, :with_followers, :with_followings) }

  it 'gets the info of the user' do
    get "/users/api/#{user.id}/api_get_info"

    expect(response.status).to eq 200

    expect(json['messages'].length).to eq(10)
  end
end