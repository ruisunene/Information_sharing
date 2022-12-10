class CreateInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :infos do |t|
      t.string :title, null: false
      t.text :body,    null: false
      t.integer :user_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
