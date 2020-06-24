MAX_NUMBER_OF_STOPS = 480



def count_stops_to_exchange_all_gossips routes
  drivers = routes.map { |route| Driver.new(route) }

  matching_stop = 1.upto(MAX_NUMBER_OF_STOPS).find do

    drivers.group_by(&:stop).each do |_, drivers|
      drivers.each { |driver| driver.add_gossips(drivers) }
    end

    drivers.each(&:move)

    drivers.all? { |driver| driver.has_all_gossips?(drivers) }
  end
  matching_stop || :never
end

class Driver

  @@counter = 0

  def initialize route
    token = @@counter.to_s.to_sym
    @@counter+= 1
    @gossips = [token]
    @route = route
    @stop_index = 0
  end

  def gossips
    @gossips.clone
  end

  def add_gossips drivers
    new_gossips = drivers.map(&:gossips).flatten
    @gossips = (@gossips + new_gossips).uniq
  end

  def stop
    @route[@stop_index]
  end

  def move
    @stop_index = (@stop_index + 1) % @route.size
  end

  def has_all_gossips? drivers
    @gossips.size == drivers.size
  end
end
