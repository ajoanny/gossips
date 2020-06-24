MAX_NUMBER_OF_STOPS = 480

def count_stops_to_exchange_all_gossips routes
  meet = 0

  driver_gossisp = routes.size.times.map { |driver_index| [driver_index, [driver_index]] }.to_h

  matching_stop = MAX_NUMBER_OF_STOPS.times.find do |slice_index|

    current_stops_of_drivers = routes.map do |route|
      stop = slice_index % route.size
      route[stop]
    end

    driver_by_stop = current_stops_of_drivers.map{ |stop| [stop, []] }.to_h
    current_stops_of_drivers.map.with_index { |stop, driver| driver_by_stop[stop] << driver }



    driver_by_stop.each do |_, drivers|
      gossips = drivers.map { |driver| driver_gossisp[driver] }.flatten
      drivers.each do |current_driver|
        knowned_gossips = driver_gossisp[current_driver] + gossips

        driver_gossisp[current_driver] = knowned_gossips.uniq
      end
    end

    if(driver_gossisp.all? { |_, gossips| gossips.size == routes.size })
      return slice_index + 1;
    end
  end

  matching_stop || :never
end
