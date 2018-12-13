require "rails_helper"

RSpec.describe EmailValidatorMailer, type: :mailer do
  describe "verify_email" do
    let(:user) { create(:user) }
    let(:mail) { EmailValidatorMailer.with(user: user).verify_email }
    
    it "should be to the user" do
      expect(mail.to).to include(user.email)
    end

    it "should be from artworkdraft" do
      expect(mail.from).to include("emailverifier@artworkdraft.com")
    end

    it "has a subject" do
      expect(mail.subject).to_not be_nil
    end

    it "welcomes the user to AWD" do
      expect(mail.subject).to eq("Welcome to ArtWorkDraft!")
    end

    describe "the body" do
      subject{ mail.body.encoded }

      it { is_expected.to match(user.email_confirmation_token) }
      it { is_expected.to match(user.name) }
    end
  end
end
