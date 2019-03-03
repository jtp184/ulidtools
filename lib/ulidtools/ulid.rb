require 'securerandom'
require 'base32/crockford'

module ULIDTools # :nodoc:
  # The ULID class keeps an internal bytestring representation of itself
  # and facilitates other representations.
  class ULID
    include Comparable

    # Format string to pack the string as a UUID instead of a ULID
    UUID_PACKING = 'H8H4H4H4H12'.freeze

    # The raw representation is a bytestring copy of the ULID
    attr_reader :raw

    # the +opts+ array can directly set the +raw+ or accept a :time key to
    # Use a time other than Time.now to generate ULIDs with
    def initialize(opts = {})
      @raw ||= opts.fetch(:raw) { opts.fetch(:time, generate_bytestring) }
    end

    # Uses the Crockford library to encode the ULID
    def to_s
      Base32::Crockford.encode(ulid_bitmath, length: 26)
    end

    # For implicit string conversion
    def to_str
      to_s
    end

    # Outputs the ULID packed instead as a UUID
    def to_uuid
      raw.unpack(UUID_PACKING).join('-')
    end

    # Compares to +other+ via the ULID#raw method
    def <=>(other)
      raw <=> other.raw
    rescue NoMethodError
      nil
    end

    private

    # Does the bitmath to prep the bytestring for Crockford encoding
    def ulid_bitmath
      (x, y) = raw.unpack('Q>Q>')
      (x << 64) | y
    end

    # Takes the +time+, processes it and adds it to the random bytes
    def generate_bytestring(time = Time.now)
      generate_time_bytes(time) + generate_random_bytes
    end

    # Packs the +time+ into a bytestring
    def generate_time_bytes(time)
      millis = time.to_f
                   .*(1000)
                   .to_i

      [millis].pack('Q>')[2..-1]
    end

    # Uses SecureRandom to make the 10 random bytes
    def generate_random_bytes
      SecureRandom.random_bytes(10)
    end
  end
end
