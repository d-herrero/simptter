require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  it { expect have_many :followers }

  it { expect have_many :following }

  it { expect have_many :messages }

  it { expect validate_presence_of :name }

  it { expect validate_presence_of :email }

  it { expect validate_uniqueness_of(:name) }

  it { expect validate_uniqueness_of(:email) }

  it { expect allow_value(user.name).for(:name) }

  it { expect allow_value(user.password).for(:password) }

  it { expect allow_value(user.email).for(:email) }
end