class ChangeTypeOfIsPublic < ActiveRecord::Migration
  def change
  	change_column :posts, :is_public, :string,  :default => "Public"
  end
end
