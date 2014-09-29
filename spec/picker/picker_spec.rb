require 'spec_helper'

describe Picker do
  describe '.pick' do
    it 'picks the element if only one element is given' do
      result = Picker.pick a: 10
      expect(result).to eq :a
    end
    
    subject {Picker.pick a: 10, b: 5, c: 3}

    it 'picks the first element if it falls in that range' do
      allow(Kernel).to receive_messages rand: 5
      expect(subject).to eq :a
    end

    it 'picks the second element if it falls in that range' do
      allow(Kernel).to receive_messages rand: 12
      expect(subject).to eq :b
    end

    it 'picks the first element if it falls in that range' do
      allow(Kernel).to receive_messages rand: 16
      expect(subject).to eq :c
    end
  end

  describe '#succesful?' do
    subject {Picker.successful? 10, 5}

    it 'is successful if the random value is smaller than the winning value' do
      allow(Kernel).to receive_messages rand: 9
      expect(subject).to be_truthy
    end

    it 'is not successfull if the losing value is rolled' do
      allow(Kernel).to receive_messages rand: 12
      expect(subject).to be_falsey
    end
  end
end