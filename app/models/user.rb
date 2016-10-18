class User < ApplicationRecord
  include Clearance::User

  has_many :collaborations
  has_many :documents, through: :collaborations

  def to_param
    MaskedId.encode(id)
  end
end
