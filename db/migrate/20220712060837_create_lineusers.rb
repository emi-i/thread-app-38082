class CreateLineusers < ActiveRecord::Migration[6.0]
  def change
    create_table :lineusers do |t|
      t.string :uid
      t.timestamps
    end
  end
end
