require 'rails_helper'

RSpec.describe UserPolicy do
  let(:duser) { create(:user) }

  subject { described_class.new(UserContext.new(user, {}), duser) }

  let(:view_actions) { %i[index show feed artworks scraps artwork_reblogs] }
  context "being a visitor" do
    let(:user) { nil }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
  end

  context "being another user" do
    let(:user) { create(:user) }
    it { is_expected.to permit_actions(view_actions) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context "being the same user" do
    let(:user) { duser }
    it { is_expected.to permit_actions(%i[show edit update destroy]) }
    it { is_expected.to permit_actions(view_actions) }
    it { is_expected.to forbid_actions(%i[new create]) }
  end
end
