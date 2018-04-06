class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :value
      t.float :height
      t.float :weight
      t.float :width
      t.float :length

      t.timestamps
    end
  end
end
