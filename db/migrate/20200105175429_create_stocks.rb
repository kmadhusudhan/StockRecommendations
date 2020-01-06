class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :title
      t.string :sector
      t.string :description

      t.timestamps
    end
  end
end
