@events = []
@trips.each do |trip|
  event = {}
  event[:id] = trip[:id]
  event[:title] = trip.name
  event[:start] = trip[:from_date]
  event[:url] = trip_path(:id => trip.id)
  event[:end] = trip[:to_date]
  @events << event
end

json.array! @events
