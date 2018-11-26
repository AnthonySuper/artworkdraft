require 'rails_helper'

RSpec.describe ScrapPolicy do
  let(:scrap) { create(:scrap) }
  let(:nsfw_scrap) { create(:scrap, nsfw: true) }

  subject { described_class.new(UserContext.new(user, cpref), scrap) }

  let(:resolved_scope) do
    described_class::Scope.new(UserContext.new(user, cpref), Scrap.all).resolve
  end

  let(:cpref) { Hash.new }

  context "being a visitor" do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[show index]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }

    before(:each) { scrap; nsfw_scrap; }

    describe "scope" do
      context "with no cpref" do

        it "excludes nsfw scraps" do
          expect(resolved_scope).not_to include(nsfw_scrap)
        end

        it "includes sfw scraps" do
          expect(resolved_scope).to include(scrap)
        end
      end

      context "with a required cpref" do
        let(:cpref) { {"nsfw" => "required"} }

        it "includes nsfw scraps" do
          expect(resolved_scope).to include(nsfw_scrap)
        end

        it "excludes sfw scraps" do
          expect(resolved_scope).not_to include(scrap)
        end
      end

      context "with an allowed cpref" do
        let(:cpref) { {"nsfw" => "allowed"} }

        it "includes nsfw scraps" do
          expect(resolved_scope).to include(nsfw_scrap)
        end

        it "includes sfw scraps" do
          expect(resolved_scope).to include(scrap)
        end
      end
    end
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
