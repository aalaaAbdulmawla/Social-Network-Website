class AddDefaultValueToAccepted < ActiveRecord::Migration
  def change
  	change_column :friendables, :accepted, :integer,  :default => 0
  end
end
