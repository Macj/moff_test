
class CountriesCurrencies < ActiveRecord::Base
  attr_accessible  :country_id, :currency_id, :visited

  def self.visited_for currency_id
    self.where(:visited => true).find_all_by_currency_id(currency_id).count
  end

  def self.not_visited_for currency_id
    self.where(:visited => false).find_all_by_currency_id(currency_id).count
  end
end