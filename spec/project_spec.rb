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
      it 'exchanges all gossips on the first stop' do
        number_of_stops = count_stops_to_exchange_all_gossips([
          [1,2],
          [2,3,4]]
        )
        expect(number_of_stops).to eq 4
      end
    end
  end
end
