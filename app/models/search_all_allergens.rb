def search_all_allergens(search_item, user_id)
  # LIKE is the SQL standard while ILIKE is a useful extension made by PostgreSQL.
  # use ILIKE in production and LIKE in development
  allergens = Allergen.where "user_id = ?", user_id

  return allergens.where "category ILIKE ? OR substances ILIKE ?", "%#{search_item}%", "%#{search_item}%"
  #return allergens.where "category LIKE ? OR substances LIKE ?", "%#{search_item}%", "%#{search_item}%"

end