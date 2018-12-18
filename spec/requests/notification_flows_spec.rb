require "rails_helper"

RSpec.describe "Notification Flows", type: :request do
  describe "trying to read notifications" do
    let(:notification) { create(:notification) }
    before(:each) { notification }
    subject do
      proc do
        login_as user
        put notification_path(notification),
          params:  { notification: { read: true } }
      end
    end

    context "as the owner" do
      let(:user) { notification.user }
      it { is_expected.to_not raise_error }
      it { is_expected.to change{notification.reload.read}.from(false).to(true) }
    end
    
    context "as a random user" do
      let(:user) { create(:user) }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end

    context "as no user" do
      let(:user) { nil }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end

  describe "trying to delete notifications" do
    let(:notification) { create(:notification) }
    before(:each) { notification } 
    subject do
      proc do
        login_as user
        delete notification_path(notification),
          headers: {"ACCEPT" => "application/json" }
      end
    end

    context "as the owner" do
      let(:user) { notification.user }
      it { is_expected.to change{user.notifications.count}.by(-1) }
      it { is_expected.to change{Notification.count}.by(-1) }
    end

    context "as a random user" do
      let(:user) { create(:user) }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end

    context "as no user" do
      let(:user) { nil }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end
end
