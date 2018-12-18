require "rails_helper"

RSpec.describe "Artwork flows", type: :request do
  before(:each) { login_as user } 
  describe "GET index" do
    subject { proc { get artworks_path } } 

    context "as a user" do
      let(:user) { create(:user) } 
      it { is_expected.to_not raise_error }
    end

    context "as a guest" do
      let(:user) { nil }
      it { is_expected.to_not raise_error }
    end
  end

  describe "POST create" do
    subject do
      proc { post artworks_path, params: { artwork: attributes } } 
    end

    context "as a user" do
      let(:user) { create(:user) }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:artwork) }
        it { is_expected.to change{Artwork.count}.by(1) }
        it { is_expected.to change{user.artworks.count}.by(1) }
      end

      context "with invalid attributes" do
        let(:attributes) { attributes_for(:artwork, name: nil) }
        it { is_expected.to_not change{Artwork.count} }
        it { is_expected.to_not change{user.artworks.count} }
      end
    end

    context "as a guest" do
      let(:user) { nil }
      let(:attributes) { attributes_for(:artwork) }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end

  describe "PUT update" do
    let(:artwork) { create(:artwork) }
    subject do
      proc { put artwork_path(artwork), params: { artwork: attributes } }
    end

    context "as the artist" do
      let(:user) { artwork.user }
      
      context "with valid attributes" do
        let(:attributes) { {name: "Test"} } 

        it { is_expected.to change{artwork.reload.attributes} }
        it { is_expected.to change{artwork.reload.name}.to("Test") }
        it { is_expected.to_not raise_error }
      end

      context "with invalid attributes" do
        let(:attributes) { {name: nil} }
        it { is_expected.to_not change{artwork.reload.attributes} }
      end
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
end
