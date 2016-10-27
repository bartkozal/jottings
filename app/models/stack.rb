class Stack < ApplicationRecord
  include Shareable

  def to_s
    return "Untitled stack" unless name.present?
    name
  end

  def to_param
    MaskedId.encode(:stack, id)
  end
end
