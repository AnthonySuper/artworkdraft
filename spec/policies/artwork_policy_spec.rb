require 'rails_helper'

RSpec.describe ArtworkPolicy do
  
  let(:artwork) { create(:artwork) }
  subject { described_class.new(UserContext.new(user, cpref), artwork) }

  let(:cpref) { Hash.new }

  context "being a visitor" do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end
end
