class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :target_id, null: false
      t.integer :achievement, null: false
      t.string :result_memo

      t.timestamps
    end
  end
end
