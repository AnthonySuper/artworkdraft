require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "relations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:payload) }
  end

  describe "scopes" do
    describe "unread" do
      let(:read) { create(:notification, read: true) }
      let(:unread) { create(:notification, read: false) }
      before(:each) { read; unread; }

      subject { described_class.unread }

      it { is_expected.to include(unread) }
      it { is_expected.to_not include(read) }
    end
  end
end
