
class CountriesCurrencies < ActiveRecord::Base
  attr_accessible  :country_id, :currency_id, :visited

  def self.visited_for currency_id
    self.where(:visited => true).find_all_by_currency_id(currency_id).count
  end

  def self.not_visited_for currency_id
    self.where(:visited => false).find_all_by_currency_id(currency_id).count
  end

  def self.collected_in country_id
    self.where(:collected => true).find_all_by_country_id(country_id).count
  end

  def self.not_collected_in country_id
    self.where(:collected => false).find_all_by_country_id(country_id).count
  end

  def self.unfinished_countries
    self.where(:visited => false).map(&:currency_id).uniq
  end
end