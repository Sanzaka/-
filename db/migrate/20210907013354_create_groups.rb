class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :intro, null: false
      t.string :image_id
      t.integer :group_type, null: false
      t.timestamps
    end
  end
end
