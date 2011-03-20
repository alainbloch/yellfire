class AddWhatToDoToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :what_to_do, :string
  end

  def self.down
    remove_column :messages, :what_to_do
  end
end
