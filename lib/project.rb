
def count_stops_to_exchange_all_gossips routes
  stop_index = nil
  routes.first.each_with_index do |stop, index|
    if routes.last[index] == stop
      stop_index = index + 1
    end
  end
  return  stop_index;
end
