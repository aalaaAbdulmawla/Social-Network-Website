class CreateFriendables < ActiveRecord::Migration
  def change
    create_table :friendables do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :accepted

      t.timestamps
    end
  end
end
