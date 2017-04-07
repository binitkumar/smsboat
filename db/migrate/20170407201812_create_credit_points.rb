class CreateCreditPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_points do |t|
      t.integer :points
      t.integer :requester_id

      t.timestamps
    end
  end
end
