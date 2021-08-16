class Mayor < ApplicationRecord
  belongs_to :city
  validates :name, :gender, presence: true
  scope :filter_by_gender, ->(gender) { where gender: gender }
end
