class AddMessageToConverstationRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :converstation_requests, :message, :text
  end
end
