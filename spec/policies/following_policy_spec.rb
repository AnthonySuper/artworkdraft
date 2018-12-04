require 'rails_helper'

RSpec.describe FollowingPolicy do
  subject { described_class.new(UserContext.new(user, {}), following) }
  context "being a visitor" do
    let(:user) { nil }
    let(:following) { create(:following) }
    it { is_expected.to forbid_actions(%i[create destroy]) }
  end

  context "being the right user" do
    let(:user) { create(:user) }
    let(:following) { create(:following, follower: user) }
    it { is_expected.to permit_actions(%i[create destroy]) }
  end

  context "being a random user" do
    let(:user) { create(:user) }
    let(:following) { create(:following) }
    it { is_expected.to forbid_actions(%i[create destroy]) }
  end

  context "being the followed user" do
    let(:user) { create(:user) }
    let(:following) { create(:following, followee: user) }
    it { is_expected.to forbid_actions(%i[create destroy]) }
  end
end
