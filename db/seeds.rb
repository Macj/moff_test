# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
c = Country.create(:name => 'USA')
c1 = Country.create(:name => 'Ukrain')
c2 = Country.create(:name => 'Russia')
c3 = Country.create(:name => 'Belorussia')
c4 = Country.create(:name => 'Poland')
c5 = Country.create(:name => 'Hungary')
c6 = Country.create(:name => 'France')

cu1 = Currency.create(:name => "USD")
cu1.countries << [c]

cu1 = Currency.create(:name => "UH")
cu1.countries << [c1]

cu1 = Currency.create(:name => "RUB")
cu1.countries << [c2]

cu1 = Currency.create(:name => "EUR")
cu1.countries << [c4, c5, c6]