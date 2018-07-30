def create_reaction(product,allergen,ingredient,substances)

  Reaction.create(product_id: product.id, 
    allergen_id: allergen.id, 
    reactive_substances: substances,
    reactive_ingredient: ingredient.upcase,
    user_id: product.user_id)

end