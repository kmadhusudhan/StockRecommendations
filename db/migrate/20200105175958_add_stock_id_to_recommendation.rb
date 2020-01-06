class AddStockIdToRecommendation < ActiveRecord::Migration[5.1]
  def change
    add_column :recommendations, :stock_id, :integer
  end
end
