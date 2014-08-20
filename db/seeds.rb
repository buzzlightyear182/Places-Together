# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create username: "buzzlightyear182", fullname: "Jane Dee", password: '12345678', email: "jane.buzzlightyear@gmail.com"
user2 = User.create username: "rcsole", fullname:"Ricard Sole", password: '12345678', email: "rcsole@gmail.com"
user3 = User.create username: "kristiankiwi", fullname:"Kristian Kyvik", password: '12345678', email: "kristiankyvik@gmail.com"
user4 = User.create username: "bentarenne", fullname:"Ben Tarenne", password: '12345678', email: "bentarenne@gmail.com"
user5 = User.create username: "cat1788", fullname:"Cat Burston", password: '12345678', email: "cat1788@gmail.com"
user6 = User.create username: "rogerbriz", fullname:"Roger Briz", password: '12345678', email: "rogerbriz@gmail.com"
user7 = User.create username: "mentor", fullname: "Wojtek Ogrodowczyk", password: '12345678', email: "wojtek.ogrodowczyk@gmail.com"

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

trip1 = Trip.create organizer: user1.id, place_id: place1.id, activity_id: activity1.id, from_date: Date.today+30, to_date: Date.today+32, description: "Wreck dive", capacity: 10

trip2 = Trip.create organizer: user2.id, place_id: place3.id, activity_id: activity2.id, from_date: Date.today+1, to_date: Date.today+2, description: "Code kata", capacity: 5

trip3 = Trip.create organizer: user3.id, place_id: place5.id, activity_id: activity3.id, from_date: Date.today+2, to_date: Date.today+3, description: "Night out", capacity: 8

trip4 = Trip.create organizer: user6.id, place_id: place4.id, activity_id: activity4.id, from_date: Date.today+6, to_date: Date.today+9, description: "Climb mountains", capacity: 4

trip5 = Trip.create organizer: user4.id, place_id: place2.id, activity_id: activity5.id, from_date: Date.today+4, to_date: Date.today+7, description: "Eat french cheese", capacity: 3

Participation.create user_id: user2.id, trip_id: trip1.id, confirmed: false
Participation.create user_id: user7.id, trip_id: trip2.id, confirmed: false
Participation.create user_id: user1.id, trip_id: trip3.id, confirmed: false
Participation.create user_id: user5.id, trip_id: trip4.id, confirmed: false
Participation.create user_id: user3.id, trip_id: trip5.id, confirmed: false