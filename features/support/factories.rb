FactoryBot.define do
  factory :ulid, class: ULIDTools::ULID do
    raw do
      [
        1, 105, 50, 23,
        249, 174, 31, 106,
        184, 238, 223, 57,
        101, 218, 100, 251
      ].map(&:chr).join
    end
  end
end
