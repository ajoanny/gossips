MAX_NUMBER_OF_STOPS = 480



def count_stops_to_exchange_all_gossips routes
  driver_gossisp = routes.map.with_index { |route, driver_index| [driver_index, Driver.new(route)] }.to_h

  matching_stop = MAX_NUMBER_OF_STOPS.times.find do |stop_number|

    drivers_by_stop(routes, stop_number, driver_gossisp.values).each do |_, driver_indexs|
      drivers = driver_indexs.map { |i| driver_gossisp[i] }
      gossips = drivers.map(&:gossips).flatten

      drivers.each do |driver|
        driver.add_gossips gossips
      end
    end

    if(driver_gossisp.all? { |_, driver| driver.gossips.size == routes.size })
      return stop_number + 1;
    end

  end

  matching_stop || :never
end

private

def drivers_by_stop(routes, stop_number, drivers)
  driver_by_stop = {}

  routes.each.with_index do |route, driver|
    index = stop_number % route.size
    stop = route[index]

    driver_by_stop[stop] ||= []
    driver_by_stop[stop] << driver
  end

  driver_by_stop
end

class Driver

  @@counter = 0

  def initialize route
    token = @@counter.to_s.to_sym
    @@counter+= 1
    @gossips = [token]
  end

  def gossips
    @gossips.clone
  end

  def add_gossips gossips
    @gossips = (@gossips +gossips).uniq
  end
end
