class CreateSmsMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :sms_messages do |t|
      t.integer :requester_id
      t.integer :expert_id
      t.text :message

      t.timestamps
    end
  end
end
