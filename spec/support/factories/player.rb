Factory.define :player do |f|
  f.sequence(:name) { |n| "John Smith#{n}" }
  f.sequence(:email_address) { |n| "test#{n}@test.com"}
end