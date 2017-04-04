class CreateConverstationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :converstation_requests do |t|
      t.integer :requester_id
      t.integer :exptert_id

      t.timestamps
    end
  end
end
