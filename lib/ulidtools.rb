require 'ulidtools/version'
require 'ulidtools/ulid'

# A Gem for manipulating ULIDs 
module ULIDTools
	# Shortcut to ULID#new
  def self.generate
    ULID.new
  end
end
