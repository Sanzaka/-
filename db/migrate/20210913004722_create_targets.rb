class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.string :target_content, null: false

      t.timestamps
    end
  end
end
