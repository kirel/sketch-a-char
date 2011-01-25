Factory.define :user do |u|
  u.sequence(:name) { |i| "user#{i}" }
end

Factory.define :sym do |s|
  s.sequence(:name) { |i| "symbol#{i}" }
end