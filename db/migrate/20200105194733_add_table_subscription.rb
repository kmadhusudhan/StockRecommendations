class AddTableSubscription < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :endpoint
      t.string :p256dh
      t.string :auth

      t.timestamps
    end
    create_table :web_push_notifications do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
