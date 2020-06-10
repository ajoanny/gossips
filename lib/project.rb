
def count_stops_to_exchange_all_gossips routes
  stop_index = nil

  first_driver_stops = routes.first
  last_driver_stops = routes.last

  first_driver_stops.each_with_index do |stop, index|
    if last_driver_stops[index] == stop
      stop_index = index + 1
    end
  end

  return  stop_index;
end
