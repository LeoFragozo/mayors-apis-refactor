class MayorSerializer < ActiveModel::Serializer
  attributes :name, :gender, :cities
  def cities
    object.cities.map do |city|
      { name: city.name }
    end
  end
end
