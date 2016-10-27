require 'hashids'

class MaskedId
  class << self
    attr_accessor :table_name

    def decode(table_name, hash)
      self.table_name = table_name
      formatter.decode(hash).first
    end

    def encode(table_name, id)
      self.table_name = table_name
      formatter.encode(id)
    end

    private

    def salt
      "#{table_name}_#{Rails.application.secrets.hashids_salt}"
    end

    def formatter
      Hashids.new(salt, 8)
    end
  end
end
