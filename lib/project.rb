
def count_stops_to_exchange_all_gossips routes
  first_driver_stops = routes.first
  last_driver_stops = routes.last

  stop = first_driver_stops.find do |stop|
    last_driver_stops.include? stop
  end

  first_driver_stops.index(stop) + 1
end
