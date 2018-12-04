require 'rails_helper'

RSpec.describe Following, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:followee) }
    it { is_expected.to validate_presence_of(:follower) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:followee) }
    it { is_expected.to belong_to(:follower) }
  end
end
