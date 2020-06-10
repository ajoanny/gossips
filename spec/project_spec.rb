require 'project'

describe 'Gossiping Bus Drivers' do
  describe 'when all the drivers start from the same stop' do
    it 'exchanges all gossips on the first stop' do
      number_of_stops = count_stops_to_exchange_all_gossips([[1],[1]])
      expect(number_of_stops).to eq 1
    end
  end

  describe 'when all the drivers do not start from the same stop' do
    it 'exchanges all gossips on the second stop' do
      number_of_stops = count_stops_to_exchange_all_gossips([[1,2],[3,2]])
      expect(number_of_stops).to eq 2
    end

    it 'exchanges all gossips on the first stop where they meet' do
      number_of_stops = count_stops_to_exchange_all_gossips([[1,2,5],[3,2,4]])
      expect(number_of_stops).to eq 2
    end
  end
end
