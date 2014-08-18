# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create username: "buzzlightyear182", fullname:"Jane Dee", password: '12345678', email: "jane.buzzlightyear@gmail.com"
user2 = User.create username: "rcsole", fullname:"Ricard Sole", password: '12345678', email: "rcsole@gmail.com"
user3 = User.create username: "kristiankiwi", fullname:"Kristian Kyvik", password: '12345678', email: "kristiankyvik@gmail.com"
user4 = User.create username: "bentarenne", fullname:"Ben Tarenne", password: '12345678', email: "bentarenne@gmail.com"
user5 = User.create username: "cat1788", fullname:"Cat Burston", password: '12345678', email: "cat1788@gmail.com"
user6 = User.create username: "rogerbriz", fullname:"Roger Briz", password: '12345678', email: "rogerbriz@gmail.com"

place1 = Place.create city: 'Manila', country: 'Philippines', user_id: user1.id
place2 = Place.create city: 'Montpellier', country: 'France', user_id: user5.id
place3 = Place.create city: 'Barcelona', country: 'Spain', user_id: user2.id
place4 = Place.create city: 'Bilbao', country: 'Spain', user_id: user6.id
place5 = Place.create city: 'Oslo', country: 'Norway', user_id: user3.id

activity1 = Activity.create activity_name: "Diving", category: "Water Sport", user_id: user1.id
activity2 = Activity.create activity_name: "Hackathon", category: "Indoor", user_id: user2.id
activity3 = Activity.create activity_name: "Fiesta", category: "Nightlife", user_id: user3.id
activity4 = Activity.create activity_name: "Trek", category: "Outdoor", user_id: user6.id

Trip.create organizer: user1.id, place_id: place1.id, activity_id: activity1.id, from_date: Date.today+30, to_date: Date.today+32, member: user4.id, description: "Wreck dive", verified: false, capacity: 10

Trip.create organizer: user2.id, place_id: place3.id, activity_id: activity2.id, from_date: Date.today+1, to_date: Date.today+2, member: user4.id, description: "Code kata", verified: false, capacity: 5

Trip.create organizer: user3.id, place_id: place5.id, activity_id: activity3.id, from_date: Date.today+2, to_date: Date.today+3, member: user6.id, description: "Night out", verified: false

Trip.create organizer: user6.id, place_id: place4.id, activity_id: activity4.id, from_date: Date.today+6, to_date: Date.today+9, member: user5.id, description: "Climb mountains", verified: false, capacity: 4