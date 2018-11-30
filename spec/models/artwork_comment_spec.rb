require 'rails_helper'

RSpec.describe ArtworkComment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:artwork) }
    it { is_expected.to validate_presence_of(:body) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:artwork) }
    it { is_expected.to belong_to(:user) }
  end
end
