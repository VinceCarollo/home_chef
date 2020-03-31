FactoryBot.define do
  factory :chef do
    first_name { "John" }
    last_name  { "Doe" }
    email  { "JohnDoe@example.com" }
    self_description { 'Best chef ever' }
    
    association :address, factory: :address
  end
end