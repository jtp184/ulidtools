# ULIDTools

ULIDTools is designed to provide a ruby implementation of [ULID](https://github.com/alizain/ulid) that takes advantage of their 128-bit compatibility to emulate some of the behavior of working with UUIDs.

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

```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
