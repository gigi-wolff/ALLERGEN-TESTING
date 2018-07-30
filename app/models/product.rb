class Product < ApplicationRecord
  # dependent: :destroy, rails will destroy all reactions associated with Product when its deleted
  has_many  :reactions, dependent: :destroy
  # A has_many :through association is often used to set up a many-to-many connection 
  # with another model (Reaction). This association indicates that the declaring model (Product) can be 
  # matched with zero or more instances of another model (Allergen) by proceeding through a third model (Reaction).
  has_many  :allergens, through: :reactions
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :name, presence: true
  #to validate more than one column (or more), you can add that to the scope
  validates_uniqueness_of :name, presence: true, :case_sensitive => false, :scope => [:user_id], length: {minimum: 3}
  validates :ingredients, presence: true, length: {minimum: 3}
  #validates :ingredients, format: { with: /\w+,\s/, :message => 'Ingredients must be seperated by ,' }
  validates :ingredients, format: { without: /;/, :message => "contains a ';' which is not a valid charcter" }


  # The model should be able to answer the question "Can user x do y to this object?"
  # When you write regular methods in the model those methods are all instance methods.  
  # In other words def some_method will be a method available on each retrieved record

  # After product has been created or updated (and saved) check if product contains allergens
  # and modify Reaction db accordingly
  after_save do |product|
    check_for_allergens(product)
  end

end

