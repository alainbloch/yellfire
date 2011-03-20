class AddMoreFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :mailing_list, :string
  end

  def self.down
    remove_column :users, :mailing_list
  end
end
