require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "relations" do
    it { is_expected.to have_many(:artwork_tags) }
    it { is_expected.to have_many(:artworks) }
    it { is_expected.to have_many(:scrap_tags) }
    it { is_expected.to have_many(:scraps) }
  end
end
