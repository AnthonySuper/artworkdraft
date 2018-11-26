require 'rails_helper'

RSpec.describe ScrapPolicy do
  let(:scrap) { create(:scrap) }

  subject { described_class.new(UserContext.new(user, {}), scrap) }

  context "being a visitor" do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[show index]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context "being a user" do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions(%i[show index new create]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end

  context "being the scrap's creator" do
    let(:user) { scrap.user }

    it { is_expected.to permit_actions(
      %i[show index new create edit update destroy]) }
  end
end
