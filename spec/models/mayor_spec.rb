require 'rails_helper'

RSpec.describe Mayor, type: :model do
  let(:city) { create(:city) }
  describe 'male/female scopes test' do
    it 'show only male mayors' do
      male = Mayor.create!(gender: 'male', city_id: city.id)
      expect(Mayor.is_male).to include(male)
    end
    it 'show only female mayors' do
      female = Mayor.create!(gender: 'female', city_id: city.id)
      expect(Mayor.is_female).to include(female)
    end
  end
end
