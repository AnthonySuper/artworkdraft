require 'rails_helper'

RSpec.describe NotificationsPolicy do
  let(:notification) { create(:notification) }
  subject { described_class.new(UserContext.new(user, {}), notification) }
  let(:actions) {%i[show update index destroy] }

  context "with the owner" do
    let(:user) { notification.user }
    it { is_expected.to permit_actions(actions) }
  end

  context "with no user" do
    let(:user) { nil }
    it { is_expected.to forbid_actions(actions) }
  end

  context "with a different user" do
    let(:user) { create(:user) }
    it { is_expected.to forbid_actions(%i[show update destroy]) }
    it { is_expected.to permit_action(:index) } 
  end
end
