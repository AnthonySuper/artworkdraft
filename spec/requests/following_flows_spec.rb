require "rails_helper"

RSpec.describe "FollowingFlows", type: :request do
  describe "trying to create a following" do
    let(:followee) { create(:user) }

    subject do
      proc do
        login_as user
        post "/followings",
          params: { following: { followee_id: followee.id } }
      end
    end


    context "when not logged in" do
      let(:user) { nil }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end

    context "when logged in as a non-follower" do
      let(:user) { create(:user) }
      it { is_expected.to change{followee.users_following.reload.count}.by(1) }
      it { is_expected.to_not change{followee.users_followed.reload.count} }
      it { is_expected.to change{user.users_followed.reload.count}.by(1) }
      it { is_expected.to_not change{user.users_following.reload.count} }
      it { is_expected.to change{Following.count} }
      it do
        is_expected.to change{user.following? followee}.from(false).to(true)
      end
      it do
        is_expected.to change{followee.followed_by? user}.from(false).to(true)
      end
    end

    context "when logged in as a follower" do
      let(:user) { create(:user) }
      before(:each) { create(:following, followee: followee, follower: user) }
      it { is_expected.to_not change{followee.users_following.reload.count } }
      it { is_expected.to_not change{followee.users_followed.reload.count } }
      it { is_expected.to_not change{user.users_followed.reload.count } }
      it { is_expected.to_not change{user.users_following.reload.count} } 
      it { is_expected.to_not change{Following.count} } 
    end
  end

  describe "trying to destroy a following" do
    let(:followee) { create(:user) }
    subject do
      proc do
        login_as user
        delete "/followings/#{followee.id}"
      end
    end
    
    context "when not logged in" do
      let(:user) { nil }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) } 
    end

    context "when logged in as a random user" do
      let(:user) { create(:user) }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end

    context "when logged in as a following user" do
      let(:user) { create(:user) }
      before(:each) { create(:following, followee: followee, follower: user) }
      it { is_expected.to change{Following.count}.by(-1) }
      it { is_expected.to change{followee.users_following.count}.by(-1) }
      it { is_expected.to change{user.users_followed.count}.by(-1) }
      it do 
        is_expected.to change{user.following?(followee)}.from(true).to(false)
      end
    end
  end
end
