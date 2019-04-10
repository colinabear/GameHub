class AddMessagesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :messages_received, :string, array: true
    add_column :users, :messages_sent, :string, array: true
  end
end
