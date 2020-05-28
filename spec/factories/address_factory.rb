FactoryBot.define do
  factory :address do
    street { '1120 Test st' }
    city { 'Testville' }
    state { 'CO' }
    zip { '80231' }
  end
end
