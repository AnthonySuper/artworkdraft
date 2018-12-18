RSpec.shared_examples "it is tag searched" do |name, klass|

  describe "with one tag" do
    let(:tag) { create(:tag) }
    let(:model) { create(name, tags: [tag]) }
    let(:other) { create(name, tags: []) }
    before(:each) { model; other }
    subject { klass.with_tags([tag.id]) }

    it { is_expected.to include(model) }
    it { is_expected.to_not include(other) }
  end

  describe "with multiple tags" do
    let(:tag_a) { create(:tag) }
    let(:tag_b) { create(:tag) }
    let(:good) { create(name, tags: [tag_a, tag_b]) }
    let(:just_a) { create(name, tags: [tag_a]) }
    let(:just_b) { create(name, tags: [tag_b]) }

    before(:each) { good; just_a; just_b; }

    subject { klass.with_tags([tag_a, tag_b].map(&:id)) }

    it { is_expected.to include(good) }
    it { is_expected.to_not include(just_a) }
    it { is_expected.to_not include(just_b) }
  end
end
