MAX_NUMBER_OF_STOPS = 480

def count_stops_to_exchange_all_gossips routes
  first_driver_stops = routes.first
  last_driver_stops = routes.last

  matching_stop = MAX_NUMBER_OF_STOPS.times.find do |slice_index|
    first_driver_stops_index  = slice_index % first_driver_stops.size
    last_driver_stops_index  = slice_index % last_driver_stops.size
    if (first_driver_stops[first_driver_stops_index] == last_driver_stops[last_driver_stops_index])
      return slice_index + 1
    end
  end

  matching_stop || :never
end
