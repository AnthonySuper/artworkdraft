require 'rails_helper'

RSpec.describe ScrapPolicy do
  let(:scrap) { create(:scrap) }

  subject { described_class.new(user, scrap) }

  context "with no user" do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[show index]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context "with a user" do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions(%i[show index new create]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end

  context "with the creator" do
    let(:user) { scrap.user }

    it { is_expected.to permit_actions(
      %i[show index new create edit update destroy]) }
  end
end
