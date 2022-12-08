class CreateMemos < ActiveRecord::Migration[6.1]
  def change
    create_table :memos do |t|
      t.text :memo
      t.integer :user_id
      t.integer :info_id

      t.timestamps
    end
  end
end
