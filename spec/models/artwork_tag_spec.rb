require 'rails_helper'

RSpec.describe ArtworkTag, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:artwork) }
    it { is_expected.to validate_presence_of(:tag) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:artwork) }
    it { is_expected.to belong_to(:tag) }
  end
end
