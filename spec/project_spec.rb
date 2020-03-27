require 'project'

describe Project do
  let(:project) { Project.new }

  describe '#testFunction' do
    it 'returns 1' do
      expect(project.testFunction).to eq 1
    end
  end

  describe 'mock' do
    it 'calls mockFunction' do
      expect(project).to receive(:mockFunction)
      project.testFunction
    end
  end

  describe 'stub' do
    it 'calls mockFunction' do
      allow(project).to receive(:stubFunction).and_return(12)
      expect(project.testFunction).to eq 12
    end
  end
end
