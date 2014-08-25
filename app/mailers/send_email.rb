class SendEmail < ActionMailer::Base
  # require 'mandrill'
  # mandrill = Mandrill::API.new ENV['MANDRILL_APIKEY']
  default from: "placestogether@gmail.com"
  # default from: "app28633921@heroku.com"

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

  def to_notify_joiner(participation)
  	@trip = Trip.find(participation.trip_id)
  	@joiner = User.find(participation.user_id)

  	@organizer = User.find(@trip.organizer)
  	@email = @joiner.email

  	@city = Place.where(id: @trip.place_id).first.city
  	@activity = Activity.where(id: @trip.activity_id).first.activity_name

  	@link = show_trip_from_email(@trip)

  	mail(to: @email, subject: "#{@organizer.username} just added you for a trip to #{@city}")
  end

  private

  def accept_joiner(participation)
		# "http://localhost:3000/confirm_joiner/#{participation.id}"
    "http://places-together.herokuapp.com/confirm_joiner/#{participation.id}"
  end

  def show_trip_from_email(trip)
  	# "http://localhost:3000/trips/#{trip.id}"
    "http://places-together.herokuapp.com/trips/#{trip.id}"
  end
end
