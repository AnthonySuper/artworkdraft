require "rails_helper"

RSpec.describe "scraps flow", type: :request do
  before(:each) { login_as user } 

  describe "POST create" do
    subject { proc { post scraps_path, params: { scrap: attributes } } } 
    
    context "as a user" do
      let(:user) { create(:user) }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:scrap) }
        it { is_expected.to change{Scrap.count}.by(1) }
        it { is_expected.to change{user.scraps.count}.by(1) }
        it { is_expected.to_not raise_error }
      end

      context "with invalid attributes" do
        let(:attributes) { {name: "foo"} }
        it { is_expected.to_not change{Scrap.count} }
      end
    end

    context "as a guest" do
      let(:user) { nil }

      let(:attributes) { attributes_for(:scrap) }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end

  describe "GET show" do
    let(:scrap) { create(:scrap) }
    subject { proc { get scrap_path(scrap) } } 
    context "as a user" do
      let(:user) { create(:user) }
      it { is_expected.to_not raise_error }
    end
    
    context "as a guest" do
      let(:user) { nil }
      it { is_expected.to_not raise_error }
    end
  end

  describe "PUT update" do
    let(:scrap) { create(:scrap) }
    subject do
      proc do
        put scrap_path(scrap),
          params: { scrap: attributes }
      end
    end
    
    context "as the owner" do
      let(:user) { scrap.user }
      let(:attributes) { {name: "Test"} }
      it { is_expected.to change{scrap.reload.name}.to("Test") }
      it { is_expected.to change{scrap.reload.attributes} }
      it { is_expected.to_not raise_error }
    end

    context "as another user" do
      let(:user) { create(:user) }
      let(:attributes) { {name: "test"} }
      
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end

    context "as a guest" do
      let(:user) { nil }
      let(:attributes) { {name: "test"} }

      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end

  describe "GET new" do
    subject { proc { get new_scrap_path } }

    context "as a user" do
      let(:user) { create(:user) }
      it { is_expected.to_not raise_error }
    end

    context "as a guest" do
      let(:user) { nil }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end

  describe "DELETE scrap" do
    let(:scrap) { create(:scrap) }
    subject { proc { delete scrap_path(scrap) } }

    context "as a guest" do
      let(:user) { nil }

      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end

    context "as a user" do
      let(:user) { create(:user) }
      
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end

    context "as the artist" do
      let(:user) { scrap.user }

      it { is_expected.to change{Scrap.count}.by(-1) }
      it { is_expected.to change{user.scraps.count}.by(-1) }
      it { is_expected.to_not raise_error }
    end
  end
end
