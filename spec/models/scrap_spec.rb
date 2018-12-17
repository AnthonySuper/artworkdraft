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
  
  describe "pagination" do
    let(:first) { create(:scrap) }
    let(:second) { create(:scrap) }
    let(:third) { create(:scrap) }
    before(:each) { first; second; third; }
    describe "page_after" do
      it "works with the created thing" do
        expect(Scrap.page_after(second.created_at)).to contain_exactly(first)
      end
    end
    describe "page_before" do
      it "works with the second created" do
        expect(Scrap.page_before(second.created_at)).to contain_exactly(third)
      end
    end
  end

  it_behaves_like "it is tag searched", :scrap, Scrap
end
