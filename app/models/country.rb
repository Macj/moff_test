class Country < ActiveRecord::Base
  attr_accessible :name, :visited
  has_and_belongs_to_many :currencies
end
