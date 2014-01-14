class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :item_id, index: true
      t.integer :user_id, index: true
      t.datetime :borrowed_on
      t.datetime :returned_on
      t.timestamps
    end
  end
end
