require 'rails_helper'

RSpec.describe TagPolicy do
  let(:tag) { create(:tag) }
  subject { described_class.new(UserContext.new(user, {}), tag) }

  context "with a user" do
    let(:user) { create(:user) }
    it { is_expected.to permit_actions(%i[show index edit update new create]) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "without a user" do
    let(:user) { nil }
    it { is_expected.to permit_actions(%i[show index]) }
    it { is_expected.to forbid_actions(%i[edit update new create destroy]) }
  end
end
