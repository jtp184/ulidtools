require 'ulidtools/version'
require 'ulidtools/ulid'

# A Gem for manipulating ULIDs
module ULIDTools
  # Shortcut to ULID#new
  def self.generate
    ULID.new
  end

  def self.at_time(time)
  	ULID.new(time: time)
  end

  def self.parse_uuid(uuid)
  	ULID.new(raw: uuid.split('-').pack(ULID::UUID_PACKING))
  end
end
