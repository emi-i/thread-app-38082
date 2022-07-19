class CreateEmergencyLists < ActiveRecord::Migration[6.0]
  def change
    create_table :emergency_lists do |t|
      t.string :name 
      t.string :tel
      t.string :emergency_tel
      t.timestamps
    end
  end
end
