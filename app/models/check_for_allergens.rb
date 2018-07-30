def check_for_allergens(product)
  #require "pry"

  # If product exists in Reaction db, delete it so there aren't conflicting
  # results in db
  if find_reaction(product).empty?
    destroy_reaction(product)
  end

  product_ingredients = process_ingredients_string(product.ingredients)

  # test each ingredient
  product_ingredients.each do |ingredient|
    # check each ingredient in allergen db by looking for it in the substances 
    # associated with each allergen category
    allergens_causing_reactions = Allergen.where "user_id = ? AND substances ILIKE ?", product.user_id, "%#{ingredient}%" #development
    #allergens_causing_reactions = Allergen.where "user_id = ? AND substances LIKE ?", product.user_id, "%#{ingredient}%" #development
    # if ingredient matches allergens in db
    unless allergens_causing_reactions.empty? 
      # for each allergen that contains allergic substances
      allergens_causing_reactions.each do |allergen|
        # add only those matching substances to the Reaction db
        allergen_substances_matching_ingredient = get_substances(allergen,';').select {|substance| substance.upcase.include?(ingredient.upcase)}.join(';')
        create_reaction(product,allergen,ingredient,allergen_substances_matching_ingredient)
      end
    end
  end
  
end
