class RenameExptertIdToExpertIdFromConverstationRequests < ActiveRecord::Migration[5.0]
  def change
    rename_column :converstation_requests, :exptert_id, :expert_id
  end
end
