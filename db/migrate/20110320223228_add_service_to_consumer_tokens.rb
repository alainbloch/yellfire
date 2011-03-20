class AddServiceToConsumerTokens < ActiveRecord::Migration
  def self.up
    add_column :consumer_tokens, :service, :string
  end

  def self.down
    remove_column :consumer_tokens, :service
  end
end
