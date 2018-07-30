class CreateReactions < ActiveRecord::Migration[5.1]
  def change
    create_table :reactions do |t|
      t.integer "allergen_id"
      t.integer "product_id"
      t.text "reactive_substances"
      t.string "reactive_ingredient"
      t.integer "user_id"
      t.index ["allergen_id"], name: "index_reactions_on_allergen_id"
      t.index ["product_id"], name: "index_reactions_on_product_id"
      t.index ["user_id"], name: "index_reactions_on_user_id"
    end
  end
end
