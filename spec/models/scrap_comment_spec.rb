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

  describe "notifications" do
    before(:each) { commenter; artist; scrap; }
    let(:scrap) { create(:scrap, user: artist) }
    let(:commenter) { create(:user) }
    subject do 
      proc do
        create(:scrap_comment, scrap: scrap, user: commenter)
      end
    end
    
    context "with a emailed user" do
      let(:artist) do
        create(:user, notification_email_prefs: { user_commented: true })
      end
      it { is_expected.to change{Notification.count}.by(1) }
      it { is_expected.to change{artist.notifications.reload.count}.by(1) }
      it { is_expected.to have_enqueued_job.on_queue("mailers") }
    end
    context "with a non-emailed user" do
      let(:artist) do
        create(:user, notification_email_prefs: { user_commented: false })
      end
      it { is_expected.to change{Notification.count}.by(1) }
      it { is_expected.to change{artist.notifications.reload.count}.by(1) }
      it { is_expected.to_not have_enqueued_job }
    end
  end
end
