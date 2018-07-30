class CreateAllergens < ActiveRecord::Migration[5.1]
  def change
    create_table :allergens do |t|
      t.string "category"
      t.text "substances"
      t.integer "user_id"
      t.index ["user_id"], name: "index_allergens_on_user_id"
    end
  end
end
