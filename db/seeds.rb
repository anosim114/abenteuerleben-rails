# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!([{
  name: 'admin',
  password_hash: 'admin',
  email: '',
  level: 0b111,
}])

campyear = Campyear.create!([{
  year: 2019,
  participants_register_start: '2024-07-10',
  participants_register_end: '2024-08-10',
  helper_register_start: '2024-04-01',
  helper_register_end: '2024-04-10',
  accentcolor_primary: '#ff0000',
  accentcolor_secondary: '#fee000'
}])

Camp.create!([{
  campyear: campyear[0],
  date_start: '2024-08-01',
  date_end: '2024-08-14',
  participants_year_start: 2009,
  participants_year_end: 2016,
  max_participant_count: 80
}])

p "Created #{User.count} users"

p "Created #{Campyear.count} campyears"

p "Created #{Camp.count} camps"
