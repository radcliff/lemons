class CreateItems < ActiveRecord::Migration
  def change
    create_table :items, id: :uuid do |t|
      t.uuid :grower_id
      t.string :kind, null: false
      t.string :varietal
      t.text :description
      t.integer :quantity, null: false
      t.string :unit, null: false
      t.date :expiration
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
