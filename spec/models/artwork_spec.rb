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
    it { is_expected.to have_many(:artwork_tags) }
    it { is_expected.to have_many(:tags) }
  end

  describe "pagination" do
    let(:first) { create(:artwork) }
    let(:second) { create(:artwork) }
    let(:third) { create(:artwork) }
    before(:each) { [first, second, third] }
    describe "page_after" do
      it "works with the second result" do
        after = Artwork.page_after(second.created_at)
        expect(after).to contain_exactly(third)
      end
    end

    describe "page_before" do
      it "works with the second result" do
        before = Artwork.page_before(second.created_at)
        expect(before).to contain_exactly(first)
      end
    end
  end
end
