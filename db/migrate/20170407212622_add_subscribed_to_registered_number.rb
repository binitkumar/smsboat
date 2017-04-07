class AddSubscribedToRegisteredNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :registered_numbers, :subscribed, :boolean, default: false
  end
end
