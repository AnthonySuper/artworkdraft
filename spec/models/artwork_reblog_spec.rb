require 'rails_helper'

RSpec.describe ArtworkReblog, type: :model do
  describe "creation" do
    context "when creating for an artwork" do
      let(:artwork) { create(:artwork) }

      it "allows two root reblogs" do
        create(:artwork_reblog, artwork: artwork)
        expect {
          create(:artwork_reblog, artwork: artwork)
        }.to_not raise_error
      end

      it "differentiates root reblog paths" do
        a, b = 2.times.map{ create(:artwork_reblog, artwork: artwork) }
        expect(a.path).to_not eq(b.path)
      end
    end

    context "when creating for a reblog" do
      let(:reblog) { create(:artwork_reblog) }
      
      it "allows the creation of multiple at once" do
        create(:artwork_reblog, ancestor_id: reblog.id)
        expect {
          create(:artwork_reblog, ancestor_id: reblog.id)
        }.to_not raise_error
      end

      it "differentiates the path fragments" do
        a, b = 2.times.map { create(:artwork_reblog, ancestor_id: reblog.id) }
        expect(a.path).to_not eq(b.path)
      end
    end
  end
end
