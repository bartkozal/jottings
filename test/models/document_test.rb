require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  setup do
    @document = build(:document)
    @user = build(:user)
  end

  test "#to_s" do
    @document.name = "Title"
    assert_equal "Title", @document.to_s

    @document.name = ""
    assert_equal "Untitled document", @document.to_s

    @document.name = nil
    assert_equal "Untitled document", @document.to_s
  end
end
