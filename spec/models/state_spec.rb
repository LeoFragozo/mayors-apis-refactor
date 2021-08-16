require 'rails_helper'

RSpec.describe State, type: :model do
  subject do
    State.new(name: State.new, uf: State.new)
  end
  describe 'validations' do
    it 'is not valid without an name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without an uf' do
      subject.uf = nil
      expect(subject).to_not be_valid
    end
  end
end
