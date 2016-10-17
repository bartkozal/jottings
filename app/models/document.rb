class Document < ApplicationRecord
  belongs_to :user

  def title
    body.lines.first.strip
  end
end
