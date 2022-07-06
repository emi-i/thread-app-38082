class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string     :post_code,          null: false
      t.text       :address,            null: false
      t.string     :tel,                null: false
      t.string     :emergency_contact_tel,  null: false
      t.string     :emergency_contact_name,  null: false
      t.references :user,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
