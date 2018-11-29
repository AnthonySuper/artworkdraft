require 'rails_helper'

RSpec.describe ScrapComment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:scrap) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:scrap) }
  end
end
