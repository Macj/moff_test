class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.boolean :collected, :default => false

      t.timestamps
    end
  end
end
