class AddStatusToRegisteredNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :registered_numbers, :status, :string, default: 'Open'
  end
end
