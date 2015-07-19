class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists, id: :uuid do |t|
      t.uuid :grower_id, null: false
      t.jsonb :items, default: []

      t.timestamps null: false
    end
  end
end
