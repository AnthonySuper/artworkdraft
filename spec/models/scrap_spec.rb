require 'rails_helper'

RSpec.describe Scrap, type: :model do
  describe "validations" do
    it { is_expected.to allow_value("").for(:name) }
    it { is_expected.to allow_value("").for(:description) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
