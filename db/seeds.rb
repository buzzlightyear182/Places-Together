# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Profile.delete_all
Place.delete_all
Trip.delete_all
Review.delete_all
Activity.delete_all

user1 = User.create username: "buzzlightyear182",  password: '123456', email: "jane.buzzlightyear@gmail.com"
user2 = User.create username: "rcsole", password: '123456', email: "rcsole@gmail.com"
user3 = User.create username: "kristiankiwi", password: '123456', email: "kristianruizkyvik@gmail.com"
user4 = User.create username: "bentarenne", password: '123456', email: "tarennebenjamin@gmail.com"
user5 = User.create username: "cat1788", password: '123456', email: "cat1788@gmail.com"
user6 = User.create username: "rogerbriz", password: '123456', email: "rjb_infynyte@hotmail.com"
user7 = User.create username: "mentor", password: '123456', email: "wojtek.ogrodowczyk@gmail.com"
user8 = User.create username: "darioc", password: '123456', email: "dariocavanillas@gmail.com"

place1 = Place.create city: 'Manila', country: 'Philippines'
place2 = Place.create city: 'Montpellier', country: 'France'
place3 = Place.create city: 'Barcelona', country: 'Spain'
place4 = Place.create city: 'Bilbao', country: 'Spain'
place5 = Place.create city: 'Oslo', country: 'Norway'
place6 = Place.create city: 'Stockholm', country: 'Sweden'

activity1 = Activity.create activity_name: "Diving", category: "Water Sport"
activity2 = Activity.create activity_name: "Hackathon", category: "Indoor"
activity3 = Activity.create activity_name: "Fiesta", category: "Nightlife"
activity4 = Activity.create activity_name: "Trek", category: "Outdoor"
activity5 = Activity.create activity_name: "Tourism", category: "Leisure"

trip1 = Trip.create organizer: user1.id, place_id: place1.id, activity_id: activity1.id, from_date: Date.today+30, to_date: Date.today+32, description: "Wreck dive", capacity: 10, name: "#{activity1.activity_name} in #{place1.city}"

trip2 = Trip.create organizer: user2.id, place_id: place3.id, activity_id: activity2.id, from_date: Date.today+1, to_date: Date.today+2, description: "Code kata", capacity: 6, name: "#{activity2.activity_name} in #{place3.city}"

trip3 = Trip.create organizer: user3.id, place_id: place5.id, activity_id: activity3.id, from_date: Date.today+2, to_date: Date.today+3, description: "Night out", capacity: 8, name: "#{activity3.activity_name} in #{place5.city}"

trip4 = Trip.create organizer: user6.id, place_id: place4.id, activity_id: activity4.id, from_date: Date.today+6, to_date: Date.today+9, description: "Climb mountains", capacity: 6, name: "#{activity4.activity_name} in #{place4.city}"

trip5 = Trip.create organizer: user4.id, place_id: place2.id, activity_id: activity5.id, from_date: Date.today+4, to_date: Date.today+7, description: "Eat french cheese", capacity: 4, name: "#{activity5.activity_name} in #{place2.city}"

Participation.create user_id: user1.id, trip_id: trip1.id, confirmed: true
Participation.create user_id: user2.id, trip_id: trip1.id, confirmed: true
Participation.create user_id: user3.id, trip_id: trip1.id, confirmed: true
Participation.create user_id: user4.id, trip_id: trip1.id, confirmed: true
Participation.create user_id: user5.id, trip_id: trip1.id, confirmed: true
Participation.create user_id: user6.id, trip_id: trip1.id, confirmed: true
Participation.create user_id: user7.id, trip_id: trip1.id, confirmed: true

Participation.create user_id: user2.id, trip_id: trip2.id, confirmed: true
Participation.create user_id: user8.id, trip_id: trip2.id, confirmed: true
Participation.create user_id: user3.id, trip_id: trip2.id, confirmed: true
Participation.create user_id: user4.id, trip_id: trip2.id, confirmed: true
Participation.create user_id: user5.id, trip_id: trip2.id, confirmed: true
Participation.create user_id: user6.id, trip_id: trip2.id, confirmed: true
Participation.create user_id: user7.id, trip_id: trip2.id, confirmed: true

Participation.create user_id: user1.id, trip_id: trip3.id, confirmed: true
Participation.create user_id: user2.id, trip_id: trip3.id, confirmed: true
Participation.create user_id: user3.id, trip_id: trip3.id, confirmed: true
Participation.create user_id: user4.id, trip_id: trip3.id, confirmed: true
Participation.create user_id: user5.id, trip_id: trip3.id, confirmed: true
Participation.create user_id: user6.id, trip_id: trip3.id, confirmed: true
Participation.create user_id: user7.id, trip_id: trip3.id, confirmed: true

Participation.create user_id: user1.id, trip_id: trip4.id, confirmed: true
Participation.create user_id: user2.id, trip_id: trip4.id, confirmed: true
Participation.create user_id: user3.id, trip_id: trip4.id, confirmed: true
Participation.create user_id: user5.id, trip_id: trip4.id, confirmed: true
Participation.create user_id: user6.id, trip_id: trip4.id, confirmed: true
Participation.create user_id: user7.id, trip_id: trip4.id, confirmed: true

Participation.create user_id: user1.id, trip_id: trip5.id, confirmed: true
Participation.create user_id: user2.id, trip_id: trip5.id, confirmed: true
Participation.create user_id: user3.id, trip_id: trip5.id, confirmed: true
Participation.create user_id: user4.id, trip_id: trip5.id, confirmed: true
