require 'rails_helper'

describe 'Users API' do
  let(:user) { create(:user, :with_messages, :with_followers, :with_followings) }
  let(:user_fields) { %w(id name email created_at updated_at).sort }
  let(:message_fields) { %w(id text date_time user_id).sort }

  it 'gets the info of the user' do
    get "/users/api/#{user.id}/get_info"

    expect(response.status).to eq 200

    expect(json.keys.sort).to eq(user_fields)

    expect(json.values.select{ |x| x.blank? }).to eq(Array.new)
  end

  it 'gets the messages of the user' do
    get "/users/api/#{user.id}/get_messages"

    expect(response.status).to eq 200

    expect(json).to be_a Array

    expect(json.length).to eq(5)

    expect(json[0].keys.sort).to eq(message_fields)

    expect(json[0].values.select(&:blank?)).to eq(Array.new)
  end

  it 'gets the followers of the user' do
    get "/users/api/#{user.id}/get_followers"

    expect(response.status).to eq 200

    expect(json).to be_a Array

    expect(json.length).to eq(5)

    expect(json[0].keys.sort).to eq(user_fields)

    expect(json[0].values.select(&:blank?)).to eq(Array.new)
  end

  it 'gets the users who are following the user' do
    get "/users/api/#{user.id}/get_followings"

    expect(response.status).to eq 200

    expect(json).to be_a Array

    expect(json.length).to eq(5)

    expect(json[0].keys.sort).to eq(user_fields)

    expect(json[0].values.select(&:blank?)).to eq(Array.new)
  end
end