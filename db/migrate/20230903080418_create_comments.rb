class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :recipe_id, null: false
      t.integer :customer_id, null: false
      t.string :comment, null: false
      t.integer :review, null: false

      t.timestamps
    end
  end
end
