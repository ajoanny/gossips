MAX_NUMBER_OF_STOPS = 480



def count_stops_to_exchange_all_gossips routes
  driver_gossisp = routes.size.times.map { |driver_index| [driver_index, Driver.new] }.to_h

  matching_stop = MAX_NUMBER_OF_STOPS.times.find do |stop_number|

    drivers_by_stop(routes, stop_number).each do |_, drivers|
      gossips = gossips_to_exchange(driver_gossisp, drivers)

      drivers.each do |current_driver|
        shared_gossip current_driver, driver_gossisp, gossips
      end
    end

    if(driver_gossisp.all? { |_, driver| driver.gossips.size == routes.size })
      return stop_number + 1;
    end

  end

  matching_stop || :never
end

private

def drivers_by_stop(routes, stop_number)
  driver_by_stop = {}

  routes.each.with_index do |route, driver|
    index = stop_number % route.size
    stop = route[index]

    driver_by_stop[stop] ||= []
    driver_by_stop[stop] << driver
  end

  driver_by_stop
end

def gossips_to_exchange driver_gossisp, drivers
  drivers.map { |driver| driver_gossisp[driver].gossips }.flatten
end


def shared_gossip current_driver, driver_gossisp, gossips
   driver_gossisp[current_driver].add_gossips gossips
end


class Driver

  @@counter = 0

  def initialize
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
