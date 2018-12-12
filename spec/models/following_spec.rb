require 'rails_helper'

RSpec.describe Following, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:followee) }
    it { is_expected.to validate_presence_of(:follower) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:followee) }
    it { is_expected.to belong_to(:follower) }
  end

  describe "notifications" do
    # create the users beforehand
    before(:each) { follower; followee; }
    subject do
      proc do 
        create(:following, followee: followee, follower: follower)
      end
    end
    let(:follower) { create(:user) }
    context "with an emailed user" do
      let(:followee) do
        create(:user, notification_email_prefs: { user_followed: true })
      end
      it { is_expected.to change{Notification.count}.by(1) }
      it { is_expected.to have_enqueued_job.on_queue("mailers") }
    end

    context "with a non-emailed user" do
      let(:followee) do
        create(:user, notification_email_prefs: { user_followed: false})
      end
      it { is_expected.to change{Notification.count}.by(1) }
      it { is_expected.to_not have_enqueued_job }
    end
  end
end
