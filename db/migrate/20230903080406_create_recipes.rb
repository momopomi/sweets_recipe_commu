class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customers_id, null: false
      t.string :recipe_name, null: false
      t.integer :required_time, null: false
      t.string :ingredient, null: false
      t.string :process, null: false
      
      t.timestamps
    end
  end
end
