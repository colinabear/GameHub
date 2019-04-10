class AddMessagesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :messages_received, :string, array: true, default: [].to_yaml
    add_column :users, :messages_sent, :string, array: true, default: [].to_yaml
  end
end
