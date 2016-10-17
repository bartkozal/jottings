require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  test "#title" do
    body = "First Line\r\nSecond Line\r\n\r\nThird Line"
    document = Document.new(body: body)

    assert_equal "First Line", document.title
  end
end
