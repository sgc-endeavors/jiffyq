class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :s3_image_key

      t.timestamps
    end
  end
end
