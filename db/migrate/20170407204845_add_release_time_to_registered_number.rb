class AddReleaseTimeToRegisteredNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :registered_numbers, :release_time, :datetime, default: Time.now
  end
end
