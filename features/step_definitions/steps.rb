# ==================================================
# Stepdefs
# ==================================================
Given(/i want to generate a ulid/i) do
  @ulid = nil
end

Given(/i send the (\w+) message to the (\w+)/i) do |msg, target|
  @result = object_router(target).method(msg.to_sym).call
end

Given(/i parse the uuid/i) do
  @result = ULIDTools.parse_uuid(@uuid)
end

Given(/i have a ulid/i) do
  Timecop.freeze do
    @time = Time.now
    @ulid = @ulid1 = ULIDTools.generate
  end
end

Given(/i have two ulids/i) do
  Timecop.freeze do
    @time = @time1 = Time.now
    @ulid = @ulid1 = ULIDTools.generate
    Timecop.travel Time.now + 10
    @ulid2 = ULIDTools.generate
  end
end

Then(/i should recieve a (\w+) formatted string/i) do |format|
  check = format_router(format)
  unless check.all? { |a| a.call(@result) }
    raise "Didn't Match! #{@result.inspect}"
  end
end

Then(/i should recieve a new ulid/i) do
  @ulid = @result
  unless @ulid.is_a?(ULIDTools::ULID)
    raise "Expected UUID, got #{@ulid.inspect} instead"
  end
end

Then(/(?:is|are|should be) correct/i) do
  raise "#{@result.inspect} Didn't match" unless @correct
end

When(/valid crockford/i) do
  b = Base32::Crockford.decode(@result)
  @correct = Base32::Crockford.encode(b, length: 26) == @result
end

When(/sort order/i) do
  @correct = @result == -1
end

Given(/i compare them/i) do
  @result = (@ulid1 <=> @ulid2)
end

Given(/i check the (first|last) (\d*) (characters|bytes)/i) do |blob, int, fmt|
  int = int.to_i
  u = @ulid

  @result = case fmt.downcase
            when 'characters'
              u.to_s.chars
            when 'bytes'
              u.raw.chars
            end
  @result = case blob.downcase
            when 'first'
              @result.first(int).join
            when 'last'
              @result.last(int).join
            end
end

When(/equate to a time/i) do
  bytes = @result
  (millis,) = "\x0\x0#{bytes[0...6]}".unpack('Q>')
  time = Time.at(millis / 1000.0).utc
  raise "Not a sensible time #{time}" unless sane_time(time)

  @correct = true
end

When(/if they are random bits/i) do
  @correct = !@result.ascii_only?
end

When(/time result/) do
  @correct = sane_time(@result, @time)
end

Given(/i want (it|them) to be created at a specific time/i) do |plural|
  @time = Time.at(728121600)

  @ulid = @ulid1 = ULIDTools::ULID.new(time: @time)
  @ulid2 = ULIDTools::ULID.new(time: @time) if plural == 'them'
end

When(/time returned is the time entered/i) do
  @correct = @ulid.time == @time
end

Given(/i have a uuid/i) do
  @result = @uuid = "0169414e-6f25-7042-cc0b-d44ebbf4235c"
end

When(/the binary timestamp is accurate/i) do
  r = @ulid.raw
  (ms,) = "\x0\x0#{r[0..6]}".unpack('Q>')
  @result = Time.at(ms / 1000.0).utc
  @correct = @result == @time
end

When(/compare the uuid and ulid/i) do
  @correct = (@ulid.to_uuid == @uuid) && (@ulid.to_s == ULIDTools.parse_uuid(@uuid).to_s)
end

Given(/i have a unique ulid and uuid/i) do
  r = [0, 169, 135, 109, 232, 0, 113, 111, 6, 114, 209, 182, 253, 47, 214, 155].map(&:chr).join
  @ulid = @ulid1 = ULIDTools::ULID.new(raw: r)
  @uuid = r.unpack(ULIDTools::ULID::UUID_PACKING).join('-')
end

# ==================================================
# Helper Functions
# ==================================================

def object_router(obj)
  case obj.downcase
  when 'generator'
    ULIDTools
  when 'ulid'
    @ulid
  else
    raise ArgumentError, "Undefined Object #{obj}"
  end
end

def format_router(fmt)
  case fmt.downcase
  when 'ulid'
    [
      ->(u) { u.length == 26 },
      ->(u) { %w[I L O U].none? { |l| u.include?(l) } }
    ]
  when 'uuid'
    [
      ->(u) { u.match? /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i }
    ]
  when 'bytes'
    [
      ->(u) { !u.ascii_only? }
    ]
  else
    raise ArgumentError, "Undefined Format #{fmt}"
  end
end

def sane_time(time, compare=Time.now)
  (0..5).cover?(time.to_i - compare.to_i)
end
