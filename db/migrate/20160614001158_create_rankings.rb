class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :item_id
      t.integer :have_count
      t.integer :want_count

      t.timestamps null: false
    end
  end
end
