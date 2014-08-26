@events = []
@trips.each do |trip|
  event = {}
  event[:id] = trip[:id]
  event[:title] = trip[:name]
  event[:start] = trip[:from_date].to_datetime
  event[:end] = trip[:to_date].to_datetime
  @events << event
end

json.array! @events
