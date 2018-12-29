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
    it { is_expected.to have_many(:users_followed) }
    it { is_expected.to have_many(:users_following) }
    it { is_expected.to have_many(:notifications) }
  end

  describe "following methods" do
    subject { create(:user) }
    
    context "when the user follows" do
      let(:user) { create(:user) }
      before(:each) { create(:following, followee: subject, follower: user) }
      it { is_expected.to be_followed_by(user) }
      it { is_expected.to_not be_following(user) }
      it { is_expected.to_not be_followable_by(user) }
      it { is_expected.to be_unfollowable_by(user) }
    end

    context "when the user doesn't follow" do
      let(:user) { create(:user) }
      it { is_expected.to_not be_followed_by(user) }
      it { is_expected.to_not be_following(user) }
      it { is_expected.to be_followable_by(user) }
      it { is_expected.to_not be_unfollowable_by(user) }
    end

    context "when the user is nil" do
      let(:user) { nil }
      it { is_expected.to_not be_followed_by(user) }
      it { is_expected.to_not be_following(user) }
      it { is_expected.to_not be_followable_by(user) }
      it { is_expected.to_not be_unfollowable_by(user) }
    end
  end

  describe "mutuals" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:user_c) { create(:user) }
    before(:each) do
      create(:following, followee: user_a, follower: user_b)
      create(:following, followee: user_b, follower: user_a)
      create(:following, followee: user_c, follower: user_b)
    end

    it "is proper" do
      expect(user_b.mutuals).to contain_exactly(user_a)
    end
  end
end
