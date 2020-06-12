# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include GeocodeHelper

Address.destroy_all
Chef.destroy_all
Client.destroy_all

denver_zips = [80012,80014,80022,80033,80123,80127,80201,80202,80203,80204,80205,80206,80207,80208,80209,80210,80211,80212,80214,80215,80216,80217,80218,80219,80220,80221,80222]
highlands_ranch_zips = [80126,80129,80122,80130,80120,80121,80131,80124,80128,80113,80125,80110,80123,80112,80237]
westminster_zips = [80003,80005,80020,80021,80023,80030,80031,80035,80036,80221,80234,80241,80260]
littleton_zips = [80120,80121,80122,80123,80124,80125,80126,80127,80128,80129,80130,80160,80161,80162,80163]

zips = [denver_zips, highlands_ranch_zips, westminster_zips, littleton_zips].flatten.map(&:to_s)

50.times do
  geo_response = GeocodeHelper.get_geo_response_from_zip(zips.shuffle.pop)
  address = Address.create_or_find_by(
              city: geo_response.city,
              state: geo_response.state,
              zip: geo_response.zip,
              street: nil
            )
  name = Faker::TvShows::SiliconValley.character.split
  random_years = (1..12).to_a
  Chef.create(
    first_name: name.first,
    last_name: name.last,
    email: Faker::TvShows::SiliconValley.email,
    password: 'password',
    unavailable: 'sat, sun',
    self_description: Faker::TvShows::SiliconValley.quote,
    specialty: Faker::TvShows::SiliconValley.app,
    years_of_pro_experience: random_years.sample,
    years_of_am_experience: random_years.sample,
    address: address
  )
end