MAX_NUMBER_OF_STOPS = 480


def count_stops_to_exchange_all_gossips routes
  drivers = routes.map { |route| Driver.new(route) }

  stop_number = 1.upto(MAX_NUMBER_OF_STOPS).find do

    _drivers_by_station(drivers).each do |drivers_on_station|
      drivers_on_station.each { |driver| driver.gossip(drivers_on_station) }
    end

    drivers.each(&:move)

    drivers.all? { |driver| driver.has_all_gossips?(drivers) }
  end
  stop_number || :never
end

def _drivers_by_station drivers
  drivers.group_by(&:station).values
end

class Driver

  @@counter = 0

  def initialize route
    token = @@counter.to_s.to_sym
    @@counter+= 1
    @known_gossips = [token]
    @route = route
    @stop_index = 0
  end

  def known_gossips
    @known_gossips.clone
  end

  def gossip drivers
    new_gossips = drivers.map(&:known_gossips).flatten
    @known_gossips = (@known_gossips + new_gossips).uniq
  end

  def station
    @route[@stop_index]
  end

  def move
    @stop_index = (@stop_index + 1) % @route.size
  end

  def has_all_gossips? drivers
    @known_gossips.size == drivers.size
  end
end
