FactoryBot.define do
  factory :chef do
    first_name { "John" }
    last_name  { "Doe" }
    email  { "JohnDoe@example.com" }
    city { "Kansas City" }
    state { "MO" }
    zip { '64086' }
    self_description { 'Best chef ever' }
  end
end