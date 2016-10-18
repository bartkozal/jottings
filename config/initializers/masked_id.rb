require 'hashids'

class MaskedId
  class << self
    def decode(hash)
      formatter.decode(hash).first
    end

    def encode(id)
      formatter.encode(id)
    end

    private

    def formatter
      Hashids.new(Rails.application.secrets.hashids_salt, 8)
    end
  end
end
