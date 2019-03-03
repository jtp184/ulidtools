# ULIDTools

ULIDTools is designed to provide a ruby implementation of [ULID](https://github.com/alizain/ulid) that takes advantage of their 128-bit compatibility with UUIDs. It's a little heavier weight than the main [ulid](https://github.com/rafaelsales/ulid) ruby implementation, and has methods to more easily create and manipulate ULIDs

## Getting started

## Usage

The ULID is stored internally as a string of bytes. The class has a few methods on it to make creating, manipulating, and storing them easier.

```ruby
u = ULIDTools.generate 
u.raw # => "\x01iANo%pB\xCC\v\xD4N\xBB\xF4#\\"
u.to_s # => "01D50MWVS5E11CR2YM9TXZ88TW"
u.to_uuid # => "0169414e-6f25-7042-cc0b-d44ebbf4235c"

# Sorting also works!

u1 = ULIDTools.generate
sleep 5
u2 = ULIDTools.generate

u2 < u1 # => true

# You can also create ULIDs as if it was a specific time.
# Useful for backfilling indexes

u3 = ULIDTool.at_time(Time.at(728121600))

u3.to_s # => "00N63PVT00M6VD4GJJ6D4G6TMB"

# And ULIDs know their timestamps as well

u3.time # => 1993-01-27 00:00:00 -0800
```

## Rails Integration
```ruby
# You can use a PoR object in Rails to serialize ULIDs to UUIDs. Here's an example for Postgres

# Somewhere
class ULIDSerializer
  def self.load(uuid)
    ULIDTools.parse_uuid(uuid)
  end

  def self.dump(ulid)
    ulid.to_uuid
  end
end

# In the Model
class SomeModel < ApplicationRecord
  serialize :ulid, ULIDSerializer
end

```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
