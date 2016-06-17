class DropFollows < ActiveRecord::Migration
  def up
    drop_table :follows    
  end
end
