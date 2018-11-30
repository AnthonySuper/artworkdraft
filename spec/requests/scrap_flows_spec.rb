require 'rails_helper'

RSpec.describe "ScrapFlows", type: :request do
  describe "GET /scraps" do
    let(:scrap_1) { create(:scrap) }
    let(:scrap_2) { create(:scrap) }
    let(:scrap_nsfw) { create(:scrap, nsfw: true) }
    before(:each) { [scrap_1, scrap_2, scrap_nsfw] }

   it "is success" do
      visit scraps_path
      expect(response).to have_http_status(200)
    end
  end
end
