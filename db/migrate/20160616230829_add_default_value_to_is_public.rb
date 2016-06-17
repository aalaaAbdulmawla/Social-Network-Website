class AddDefaultValueToIsPublic < ActiveRecord::Migration
  def change
  	change_column :posts, :is_public, :integer,  :default => 1
  end
end
