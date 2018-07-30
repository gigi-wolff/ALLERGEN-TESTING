class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string "name"
      t.text "ingredients"
      t.integer "user_id"
      t.index ["user_id"], name: "index_products_on_user_id"
    end
  end
end
