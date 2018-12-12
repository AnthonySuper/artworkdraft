require "rails_helper"

RSpec.shared_examples "a notification email body" do
  it { is_expected.to match("ArtWorkDraft") }
  it { is_expected.to match(user.name) }
  it { is_expected.to match(unsubscribe_user_url(user)) }
  it { is_expected.to match(user.unsubscribe_token) }
end

# Note: these specs kinda test some functionality of notifiers.
# This is probably bad, but for now it works out.
RSpec.describe NotifierMailer, type: :mailer do
  
  let(:mailer) { described_class.with(user: user, data: data) }

  describe "user_followed" do
    let(:following) { create(:following) }
    let(:data) { FollowingCreatedNotifier.new(following).data }
    let(:user) { following.followee }
    let(:mail) { mailer.user_followed }

    it "should be to the user" do
      expect(mail.to).to include(user.email)
    end

    it "should mention subject followings" do
      expect(mail.subject).to match(/follow/s)
    end

    describe "the body" do
      subject { mail.body.encoded }
      it { is_expected.to match(user.name) }
      it { is_expected.to match(following.follower.name) }
      it { is_expected.to match(/followed/s) }
      it_behaves_like "a notification email body"
    end
  end

  describe "user_commented" do
    let(:commenter) { create(:user) }
    let(:user) { create(:user) }
    let(:data) { CommentedNotifier.new(comment).data }

    let(:mail) { mailer.user_commented }

    context "with a scrap comment" do
      let(:scrap) { create(:scrap, user: user) }
      let(:comment) { create(:scrap_comment, user: commenter, scrap: scrap) }
      it "is sent to the user" do
        expect(mail.to).to contain_exactly(user.email)
      end

      describe "body" do
        subject { mail.body.encoded }
        it { is_expected.to match(user_url(commenter)) }
        it { is_expected.to match(scrap_url(scrap)) }
        it_behaves_like "a notification email body"
      end
    end

    context "with an artwork comment" do
      let(:artwork) { create(:artwork, user: user) }
      let(:comment) do
        create(:artwork_comment, user: commenter, artwork: artwork)
      end

      it "is sent to the user" do
        expect(mail.to).to contain_exactly(user.email)
      end

      it "mentions the word comment in the subject" do
        expect(mail.subject).to match(/comment/s)
      end

      describe "the message body" do
        subject { mail.body.encoded }
        it_behaves_like "a notification email body"
        it { is_expected.to match(artwork_url(artwork)) }
        it { is_expected.to match(user_url(commenter)) }
        it { is_expected.to match(commenter.name) }
      end
    end
  end

  describe "user_reblogged" do
    context "with a reblog of artwork" do
      let(:user) { create(:user) }
      let(:artwork) { create(:artwork, user: user) }
      let(:reblogger) { create(:user) }
      let(:reblog) { create(:artwork_reblog, artwork: artwork, user: reblogger) }
      let(:data) { ReblogNotifier.new(reblog).data }
      let(:mail) { mailer.user_reblogged }

      it "goes to the user" do
        expect(mail.to).to contain_exactly(user.email)
      end

      it "has a subject with 'reblog' in it" do
        expect(mail.subject).to match("reblog")
      end

      it "has a subject with 'ArtWorkDraft' in it" do
        expect(mail.subject).to match("ArtWorkDraft")
      end

      describe "the message body" do
        subject { mail.body.encoded }
        it_behaves_like "a notification email body"
        it { is_expected.to match(user_url(reblogger)) }
      end
    end
  end
end
