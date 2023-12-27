# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Event.create!([
  {
    title: "testtermin",
    description: "this is the description of the testtermin",
    start_date: "2023-12-31",
    link: ''
  },
  {
    title: "testtermin 2 with a longer title than it should actually be",
    description: "this is the description of the testtermin which is actuall als on the a little bit longer side",
    start_date: "2023-12-31"
  }
])

Page.create!([{
  url: 'mitarbeiter_haftungsausschluss',
  content: ''
}, {
  url: 'mitarbeiter_wichtige-infos',
  content: ''
}])

User.create!([{
  name: 'admin',
  password_hash: 'admin',
  email: '',
  level: 0b111,
}, {
  name: 'moderator',
  password_hash: 'moderator',
  email: '',
  level: 0b001,
}])

p "Created #{User.count} users"

Campyear.create!([{
  year: 2024,
  participants_register_start: '2023-07-10',
  participants_register_end: '2024-08-10',
  helper_register_start: '2023-04-01',
  helper_register_end: '2024-04-10',
  accentcolor_primary: '#ff0000',
  accentcolor_secondary: '#fee000',
  camps: [
    Camp.new(
      name: '1',
      date_start: '2024-08-01',
      date_end: '2024-08-05',
      participants_year_start: 2000,
      participants_year_end: 2004,
      max_participant_count: 60
    ),
    Camp.new(
      name: '2',
      date_start: '2024-08-07',
      date_end: '2024-08-12',
      participants_year_start: 2005,
      participants_year_end: 2008,
      max_participant_count: 80
    )
  ]
}])

p "Created #{Campyear.count} campyears"
p "Created #{Camp.count} camps"

Team.create!([
  {
    name: 'Handwerker',
    description: 'Handwerker bauen dies und das',
    enabled: true,
  },
  {
    name: 'Sportler',
    description: 'Sportler bewegen sich viel',
    enabled: true,
  },
  {
    name: 'Sauerkraut',
    description: 'Sauerkraut macht sauer, du musst aufpassen, dass das nicht passiert',
    enabled: true,
  },
  {
    name: 'Sonstiges',
    description: 'Sonstiges machen alles',
    enabled: true,
  },
  {
    name: 'Nachtwächter',
    description: 'Bewachen die Nacht',
    enabled: false,
  }
])

p "Created #{Team.count} teams"

h = Helper.new({
  surname: 'musterman',
  forename: 'max',
  birthday: '2000-01-01',
  birthplace: 'maxstadt',
  telephone: '01234',
  email: 'my@mail.com',

  streethouse: 'Industrystreet 14a',
  postcity: '32825 Megacity',

  story: 'this and that',
  duty: 'programmer',

  registrations: [
   Registration.new(
      camp: Camp.first,
      wish_first: 'Sportler',
      wish_second: 'Sonstige',
      participate: true
    )
  ]
})
h.photo.attach(io: Tempfile.new('dis is an image.png'), filename: 'img.png')
h.save

p "Created #{Helper.count} helpers"
p "Created #{Registration.count} registrations"
