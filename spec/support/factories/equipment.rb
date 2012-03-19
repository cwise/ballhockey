Factory.define :equipment do |f|
  f.sequence(:description) { |n| "equipment#{n}" }
end