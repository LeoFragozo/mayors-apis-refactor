class Mayor < ApplicationRecord
  belongs_to :city

  scope :is_male, -> { where(gender: 'male') }
  scope :is_female, -> { where(gender: 'female') }
end
