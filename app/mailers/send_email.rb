require 'pry'

class SendEmail < ActionMailer::Base
  default from: "janeheatherdee@gmail.com"

  def to_notify_organizer(participation)
  	@trip = Trip.find(participation.trip_id)
  	@joiner = User.find(participation.user_id)

  	@organizer = User.find(@trip.organizer)
  	@email = @organizer.email

  	@city = Place.where(id: @trip.place_id).first.city
  	@activity = Activity.where(id: @trip.activity_id).first.activity_name

		@link = accept_joiner(participation)

  	mail(to: @email, subject: "Someone wants to join you in #{@city}")
  end

  private

  def accept_joiner(participation)
		"http://localhost:3000/participations/#{participation.id}"
  end
end
# "http://localhost:3000/participations/#{@participation.id}"
