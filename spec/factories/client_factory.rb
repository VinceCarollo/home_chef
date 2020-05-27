FactoryBot.define do
  factory :client do
    first_name { "John" }
    last_name  { "Doe" }
    email  { "JohnDoe@example.com" }
    password { 'password' }
    
    association :address, factory: :address
  end
end