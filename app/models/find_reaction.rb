def find_reaction(product)
  if Reaction.exists?(product_id: product.id, user_id:product.user_id)
    return Reaction.where("product_id = ? AND user_id = ?", product.id, product.user_id)
  else
    return []
  end
end