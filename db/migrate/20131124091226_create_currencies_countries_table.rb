class CreateCurrenciesCountriesTable < ActiveRecord::Migration
  def change
    create_table :countries_currencies do |t|
      t.integer :country_id
      t.integer :currency_id
      t.boolean :visited, :default => false
      t.boolean :collected, :default => false
    end
  end
end
