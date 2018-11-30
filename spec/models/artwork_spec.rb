require 'rails_helper'

RSpec.describe Artwork, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to allow_value("").for(:description) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end
end
