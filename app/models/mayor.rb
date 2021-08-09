class Mayor < ApplicationRecord
  belongs_to :city

  scope :filter_by_gender, ->(gender) { where gender: gender }
end
