require 'rails_helper'

RSpec.describe ScrapCommentPolicy do
  let(:scrap_comment) { create(:scrap_comment) }

  subject { described_class.new(user, scrap_comment) }

  context "when not logged in" do
    let(:user) { nil }
    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context "when logged in" do
    let(:user) { create(:user) }
    it { is_expected.to permit_actions(%i[index show new create]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end
end
