class CreateMycsvs < ActiveRecord::Migration[5.2]
  def change
    create_table :mycsvs do |t|
      t.integer :first
      t.integer :second

      t.timestamps
    end
  end
end
