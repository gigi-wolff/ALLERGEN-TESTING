def destroy_reaction(product)
  Reaction.where("product_id = ? AND user_id = ?", product.id, product.user_id).destroy_all
end