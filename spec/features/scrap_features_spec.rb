require "rails_helper"

RSpec.describe "Scrap Features", type: :feature do
  describe "Indexing scraps" do
    let(:scrap_1) { create(:scrap) }
    let(:scrap_2) { create(:scrap) }
    let(:scrap_nsfw) { create(:scrap, nsfw: true) }
    before(:each) { [scrap_1, scrap_2, scrap_nsfw] }
    
    scenario "with no user and no pref" do
      visit scraps_path

      expect(page).to have_selector("a.centered-image-container", count: 2)
    end

    scenario "with a user that allows NSFW" do
      visit scraps_path(prefs: {nsfw: "allowed"})

      expect(page).to have_selector("a.centered-image-container", count: 3)
    end

    scenario "with a user that requires NSFW" do
      visit scraps_path(prefs: {nsfw: "required"})
      
      expect(page).to have_selector("a.centered-image-container", count: 1)
    end
  end
end
