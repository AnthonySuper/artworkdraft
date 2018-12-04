require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end


  describe "relations" do
    it { is_expected.to have_many(:scraps) }
    it { is_expected.to have_many(:scrap_comments) }
    it { is_expected.to have_many(:artworks) }
    it { is_expected.to have_many(:followings_followee) }
    it { is_expected.to have_many(:followings_follower) }
    it { is_expected.to have_many(:users_followed) }
    it { is_expected.to have_many(:users_following) }
  end
end
