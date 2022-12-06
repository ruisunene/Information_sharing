class CreateInfoComments < ActiveRecord::Migration[6.1]
  def change
    create_table :info_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :info_id

      t.timestamps
    end
  end
end
