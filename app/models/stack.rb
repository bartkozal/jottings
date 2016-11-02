class Stack < ApplicationRecord
  include Shareable

  has_many :documents

  def to_s
    return "Untitled stack" unless name.present?
    name
  end

  def to_param
    MaskedId.encode(:stack, id)
  end
end
