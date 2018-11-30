require 'rails_helper'

RSpec.describe ArtworkCommentPolicy do
  let(:artwork_comment) { create(:artwork_comment) }

  subject { described_class.new(UserContext.new(user,{}), artwork_comment) }

  context "being a visitor" do
    let(:user) { nil }
    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context "being a user" do
    let(:user) { create(:user) }
    it { is_expected.to permit_actions(%i[index show new create]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end
end
