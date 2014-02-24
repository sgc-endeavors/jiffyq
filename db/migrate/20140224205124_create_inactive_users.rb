class CreateInactiveUsers < ActiveRecord::Migration
  def change
    create_table :inactive_users do |t|
      t.integer :old_user_id

      t.timestamps
    end
  end
end
