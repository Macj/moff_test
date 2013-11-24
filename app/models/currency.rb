class Currency < ActiveRecord::Base
  attr_accessible :name, :collected
  has_and_belongs_to_many :countries

  def self.unfinished
    self.find(CountriesCurrencies.unfinished_countries)
  end
end
