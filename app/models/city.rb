class City < ApplicationRecord
  belongs_to :state
  has_one :mayor
  validates :name, presence: true
end
