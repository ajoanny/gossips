MAX_NUMBER_OF_STOPS = 480

def count_stops_to_exchange_all_gossips routes
  meet = 0

  matching_stop = MAX_NUMBER_OF_STOPS.times.find do |slice_index|

    current_stops_of_drivers = routes.map do |route|
      stop = slice_index % route.size
      route[stop]
    end

    stops_with_several_drivers = current_stops_of_drivers.select do |stop|
      current_stops_of_drivers.count(stop) > 1
    end

    if(stops_with_several_drivers.any?)
      meet += 1
    end

    if(meet == routes.size.times.sum)
      return slice_index + 1;
    end
  end

  matching_stop || :never
end
