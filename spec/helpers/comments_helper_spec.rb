require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CommentsHelper. For example:
#
# describe CommentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CommentsHelper, type: :helper do
  describe "new_comment_path" do
    it "works with a scrap" do
      scrap = create(:scrap)
      expect(helper.new_comment_path(scrap)).to eq(scrap_comments_path(scrap))
    end
  end
end
