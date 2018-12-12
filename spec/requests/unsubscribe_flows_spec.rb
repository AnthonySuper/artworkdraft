require "rails_helper"

RSpec.describe "UnsubscribeFlows", type: :request do 
  
  let(:user) { create(:user) }

  def user_prefs
    user.reload.notification_email_prefs.attributes
  end

  describe "without a token" do
    subject do
      proc do
        get unsubscribe_user_path(user)
      end
    end

    it { is_expected.to_not change{user_prefs} }
  end

  describe "with the wrong token" do
    subject do
      proc do
        get unsubscribe_user_path(user, unsubscribe_token: "-------123-----")
      end
    end
    it { is_expected.to_not change{user_prefs} }
  end

  describe "with the right token" do
    subject do
      proc do
        get unsubscribe_user_path(user, unsubscribe_token: user.unsubscribe_token)
      end
    end

    it { is_expected.to change{user_prefs} }
  end
end
