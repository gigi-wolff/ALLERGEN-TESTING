def search_all_reactions(search_item, user_id)
  # LIKE is the SQL standard while ILIKE is a useful extension made by PostgreSQL.
  # use ILIKE in production and LIKE in development
  reactions = Reaction.where "user_id = ?", user_id

  return reactions.where "reactive_ingredient ILIKE ? OR reactive_substances ILIKE ?", "%#{search_item}%", "%#{search_item}%"
  #return reactions.where "reactive_ingredient LIKE ? OR reactive_substances LIKE ?", "%#{search_item}%", "%#{search_item}%"

end