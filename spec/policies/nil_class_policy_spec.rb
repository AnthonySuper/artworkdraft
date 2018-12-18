require "rails_helper"

RSpec.describe NilClassPolicy do
  subject { described_class.new(UserContext.new(user, {}), nil) }
  let(:all_actions) { %i[index new create show edit update destroy] }

  context "with a user" do
    let(:user) { create(:user) }
    it { is_expected.to forbid_actions(all_actions) }
  end

  context "without a user" do
    let(:user) { nil }
    it { is_expected.to forbid_actions(all_actions) }
  end
end
