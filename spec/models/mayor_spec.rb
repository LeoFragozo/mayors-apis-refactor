require 'rails_helper'

RSpec.describe Mayor, type: :model do
  subject do
    Mayor.new(name: Mayor.new, gender: Mayor.new)
  end
  describe 'validations' do
    it 'is not valid without an name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without an gender' do
      subject.gender = nil
      expect(subject).to_not be_valid
    end
  end
end
