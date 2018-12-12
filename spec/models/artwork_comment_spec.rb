require 'rails_helper'

RSpec.describe ArtworkComment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:artwork) }
    it { is_expected.to validate_presence_of(:body) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:artwork) }
    it { is_expected.to belong_to(:user) }
  end

  describe "notifications" do
    before(:each) { artist; commenter; artwork; }
    let(:commenter) { create(:user) }
    let(:artwork) { create(:artwork, user: artist) }

    subject do
      proc do
        create(:artwork_comment, user: commenter, artwork: artwork)
      end
    end

    context "with an emailed user" do
      let(:artist) do
        create(:user, notification_email_prefs: { user_commented: true } )
      end
      it { is_expected.to change{Notification.count}.by(1) }
      it { is_expected.to change{artist.notifications.reload.count}.by(1) }
      it { is_expected.to have_enqueued_job.on_queue("mailers") }
    end

    context "with a nonemailed user" do
      let(:artist) do
        create(:user, notification_email_prefs: { user_commented: false } )
      end
      it { is_expected.to change{Notification.count}.by(1) }
      it { is_expected.to change{artist.notifications.reload.count}.by(1) }
      it { is_expected.to_not have_enqueued_job }
    end
  end
end
