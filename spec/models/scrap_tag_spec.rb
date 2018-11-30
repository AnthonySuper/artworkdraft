require 'rails_helper'

RSpec.describe ScrapTag, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:tag) }
    it { is_expected.to validate_presence_of(:scrap) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:tag) }
    it { is_expected.to belong_to(:scrap) }
  end
end
