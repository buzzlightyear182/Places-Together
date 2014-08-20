class SendEmail < ActionMailer::Base
  default from: "janeheatherdee@gmail.com"

  def to_notify_organizer(participation)
  	@trip = Trip.find(participation.trip_id)
  	@joiner = User.find(participation.user_id)

  	organizer = User.find(@trip.user_id)
  	@email = organizer.email

  	@subject = "Someone wants to join you in " + Place.where(place_id: trip.place_id).city

  	mail(to: @email, subject: @subject)
  end

  # private

  # def accept_participant()

  # end
end
