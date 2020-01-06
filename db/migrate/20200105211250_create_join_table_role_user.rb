class CreateJoinTableRoleUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :roles, :users do |t|
      t.index %i[role_id user_id]
      t.index %i[user_id role_id]
    end
  end
end
