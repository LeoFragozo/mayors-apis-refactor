class State < ApplicationRecord
  has_many :cities
  validates :name, :uf, presence: true
end
