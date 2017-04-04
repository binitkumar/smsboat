class CreateExperts < ActiveRecord::Migration[5.0]
  def change
    create_table :experts do |t|
      t.string :name
      t.string :contact_no

      t.timestamps
    end
  end
end
