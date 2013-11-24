class Currency < ActiveRecord::Base
  attr_accessible :name, :collected
  has_and_belongs_to_many :countries
end
