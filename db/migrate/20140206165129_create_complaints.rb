class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :type
      t.string :complainer_email
      t.string :notes
      t.string :status
      t.integer :targeted_question
      t.integer :targeted_user
      t.integer :targeted_image

      t.timestamps
    end
  end
end
