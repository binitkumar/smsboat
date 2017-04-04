class AddRegisteredNumberToConverstationRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :converstation_requests, :registered_number_id, :integer
  end
end
