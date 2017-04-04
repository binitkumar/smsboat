class AddStatusToConverstaionRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :converstation_requests, :status, :string, default: 'Open'
  end
end
