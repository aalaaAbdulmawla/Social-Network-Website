class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :attachment
      t.string :content
      t.integer :is_public
      t.references :user, index: true

      t.timestamps
    end
  end
end
