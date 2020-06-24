require 'project'

describe 'Gossiping Bus Drivers' do
  context 'when the drivers never meet' do
    it 'answers :never' do
      number_of_stops = count_stops_to_exchange_all_gossips([[1],[2]])
      expect(number_of_stops).to eq :never
    end
  end

  context 'when there are two driver' do
    context 'when drivers have the same number of stops' do
      context 'when drivers start from the same stop' do
        it 'exchanges all gossips on the first stop' do
          number_of_stops = count_stops_to_exchange_all_gossips([[1],[1]])
          expect(number_of_stops).to eq 1
        end
      end

      context 'when drivers do not start from the same stop' do
        it 'exchanges all gossips on the last stop' do
          number_of_stops = count_stops_to_exchange_all_gossips([[1,2],[3,2]])
          expect(number_of_stops).to eq 2
        end

        it 'exchanges all gossips on the first stop in common' do
          number_of_stops = count_stops_to_exchange_all_gossips([[1,2,5],[3,2,4]])
          expect(number_of_stops).to eq 2
        end

        it 'exchanges all gossips on the first stop where they meet' do
          number_of_stops = count_stops_to_exchange_all_gossips([[1,2,5],[2,1,5]])
          expect(number_of_stops).to eq 3
        end
      end
    end

    context 'when two drivers have not the same number of stops' do
      it 'exchanges all gossips on the first stop during any bus tour' do
        number_of_stops = count_stops_to_exchange_all_gossips([
          [1,2],
          [2,3,4]]
        )
        expect(number_of_stops).to eq 4
      end

      it 'exchanges all gossips on the first stop during any bus tour' do
        number_of_stops = count_stops_to_exchange_all_gossips([
                                                                  [1,2],
                                                                  [2,3,4]]
        )
        expect(number_of_stops).to eq 4
      end

      context 'when the drivers meet before the 481th stops' do
        it 'exchanges all gossips during the stop' do
          driver_1_stops = [3,1]
          driver_2_stops = Array.new(479).fill(2).push(1)
          number_of_stops = count_stops_to_exchange_all_gossips([driver_1_stops, driver_2_stops])
          expect(number_of_stops).to eq 480
        end
      end

      context 'when the drivers meet during the 481th stops' do
        it 'does not exchange gossips' do
          driver_1_stops = [1,3]
          driver_2_stops = Array.new(480).fill(2).push(1)
          number_of_stops = count_stops_to_exchange_all_gossips([driver_1_stops, driver_2_stops])
          expect(number_of_stops).to eq :never
        end
      end
    end
  end

  context 'when there are more than two driver' do
    context 'when drivers have to meet each other driver' do
      it 'returns the stop where all drivers have met' do
        number_of_stops = count_stops_to_exchange_all_gossips([
          [1, 2, 0],
          [1, 0, 3],
          [0, 2, 3]
        ])
        expect(number_of_stops).to eq 3
      end
    end

    context 'when a drivers have to wait another driver to get gossip from drivers who will never be meet' do
      it 'returns the stop last driver get all the gossips' do
        number_of_stops = count_stops_to_exchange_all_gossips([
                                                                  [1, 2, 3],
                                                                  [1, 1, 1],
                                                                  [3, 3, 3]
                                                              ])
        expect(number_of_stops).to eq 4
      end
    end
  end
end
