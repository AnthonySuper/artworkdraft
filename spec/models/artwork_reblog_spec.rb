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

      it "allows many root reblogs" do
        expect {
          10.times { create(:artwork_reblog, artwork: artwork) }
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

  describe "pagination" do
    let(:first) { create(:artwork_reblog) }
    let(:second) { create(:artwork_reblog) }
    let(:third) { create(:artwork_reblog) }
    before(:each) { first; second; third }
    describe "page_after" do
      it "works with the second" do
        after = ArtworkReblog.page_after(second.created_at)
        expect(after).to contain_exactly(first)
      end
    end
    describe "page_before" do
      it "works with the second" do
        before = ArtworkReblog.page_before(second.created_at)
        expect(before).to contain_exactly(third)
      end
    end
  end

  describe "notifications" do
    let(:artwork) { create(:artwork, user: artist) }

    context "with one layer of reblog" do
      before(:each) { artist; reblogger; artwork; }
      let(:reblogger) { create(:user) }

      subject do
        proc do
          create(:artwork_reblog, user: reblogger, artwork: artwork) 
        end
      end

      context "with an artist who is notified" do
        let(:artist) do
          create(:user, notification_email_prefs: { user_reblogged: true })
        end

        it { is_expected.to change{Notification.count}.by(1) }
        it { is_expected.to change{artist.notifications.reload.count}.by(1) }
        it { is_expected.to_not change{reblogger.notifications.reload.count} }
        it { is_expected.to have_enqueued_job.exactly(1).times }
      end

      context "with an artist who is not notified" do
        let(:artist) do
          create(:user, notification_email_prefs: { user_reblogged: false })
        end

        it { is_expected.to change{Notification.count}.by(1) }
        it { is_expected.to change{artist.notifications.reload.count}.by(1) }
        it { is_expected.to_not change{reblogger.notifications.reload.count} }
        it { is_expected.to_not have_enqueued_job }
      end
    end
  end
end
