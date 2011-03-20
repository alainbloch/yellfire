class ChangeWhatToDoToText < ActiveRecord::Migration
  def self.up
    change_column :messages, :what_to_do, :text
  end

  def self.down
    change_column :messages, :what_to_do, :string
  end
end
