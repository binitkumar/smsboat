class AddSendingToSendingFromToSmsMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :sms_messages, :sending_to, :string
    add_column :sms_messages, :sending_from, :string
  end
end
