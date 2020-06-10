
def count_stops_to_exchange_all_gossips routes
  first_driver_stops = routes.first
  last_driver_stops = routes.last

  matching_stop = :never

  first_driver_stops.size.times do |slice_index|
    if (first_driver_stops[slice_index] == last_driver_stops[slice_index])
      matching_stop = slice_index + 1
    end
  end

  matching_stop
end
