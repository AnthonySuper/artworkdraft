require 'rails_helper'

RSpec.describe Scrap, type: :model do
  describe "validations" do
    it { is_expected.to allow_value("").for(:name) }
    it { is_expected.to allow_value("").for(:description) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe "relations" do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:scrap_tags) }
    it { is_expected.to have_many(:tags) }
  end
end
