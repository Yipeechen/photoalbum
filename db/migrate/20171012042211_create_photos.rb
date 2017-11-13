class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|

      t.timestamps
      t.string :title
      t.date :date
      t.text :description
      t.string :file_location
      
    end
  end
end
