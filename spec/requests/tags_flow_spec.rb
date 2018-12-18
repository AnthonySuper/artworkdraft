require "rails_helper"

RSpec.describe "Tags flow", type: :request do
  before(:each) { login_as current_user }

  describe "POST tags/" do
    subject do
      proc do
        post tags_path,
          params: {tag: attributes}
      end
    end

    context "as a user" do
      let(:current_user) { create(:user) }

      context "with bad parameters" do
        let(:attributes) { {name: "", description: ""} }
        it { is_expected.to_not change{Tag.count} }
      end

      context "with good parameters" do
        let(:attributes) { attributes_for(:tag) }
        it { is_expected.to change{Tag.count}.by(1) }
      end
    end

    context "with no user" do
      let(:current_user) { nil }
      let(:attributes) { attributes_for(:tag) }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end

  describe "GET index" do
    subject do
      proc { get tags_path }
    end

    context "as a user" do
      let(:current_user) { create(:user) } 
      it { is_expected.to_not raise_error }
    end

    context "as a guest" do
      let(:current_user) { nil }
      it { is_expected.to_not raise_error }
    end
  end

  describe "GET new" do
    subject do
      proc { get new_tag_path }
    end
    context "as a user" do
      let(:current_user) { create(:user) }
      it { is_expected.to_not raise_error }
    end

    context "as a guest" do
      let(:current_user) { nil }
      it { is_expected.to raise_error(Pundit::NotAuthorizedError) }
    end
  end
end
