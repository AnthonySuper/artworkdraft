require 'rails_helper'

RSpec.describe UserPolicy do
  let(:duser) { create(:user) }

  subject { described_class.new(user, duser) }

  context "being a visitor" do
    let(:user) { nil }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
  end

  context "being another user" do
    let(:user) { create(:user) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context "being the same user" do
    let(:user) { duser }
    it { is_expected.to permit_actions(%i[show update destroy]) }
    it { is_expected.to forbid_action(:create) }
  end
end
