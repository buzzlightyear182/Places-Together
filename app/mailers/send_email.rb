class SendEmail < ActionMailer::Base
  mandrill = Mandrill::API.new(ENV['MANDRILL_APIKEY'] || 'gjXW9zjyNAJqUKmM2XVCYQ')
  default from: "places-together@heroku.com"
  # default from: "app28633921@heroku.com"

  def to_notify_organizer(participation)
  	@trip = participation.trip
  	@joiner = participation.user

  	@organizer = User.find(@trip.organizer)
  	@email = @organizer.email

  	@city = @trip.place.city
  	@activity = @trip.activity.activity_name

		@link = accept_joiner(participation)

  	mail(to: @email, subject: "Someone wants to join you in #{@city}")
  end

  def to_notify_joiner(participation)
    @trip = participation.trip
    @joiner = participation.user

  	@organizer = User.find(@trip.organizer)
  	@email = @joiner.email

  	@city = @trip.place.city
  	@activity = @trip.activity.activity_name

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
