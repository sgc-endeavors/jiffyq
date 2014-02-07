class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :header
      t.string :image
      t.string :question
      t.string :button1
      t.string :button2
      t.integer :origin_poll
      t.string :address
      t.string :response1
      t.string :response2

      t.timestamps
    end
  end
end
