class Allergen < ApplicationRecord
  # dependent: :destroy, rails will destroy all reactions associated with Allergen when its deleted
  has_many  :reactions, dependent: :destroy
  # A has_many :through association is often used to set up a many-to-many connection 
  # with another model (Reaction). This association indicates that the declaring model (Allergen) can be 
  # matched with zero or more instances of another model (Product) by proceeding through a third model (Reaction).
  has_many  :products, through: :reactions
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :category, presence: true
  #to validate more than one column (or more), you can add that to the scope
  validates_uniqueness_of :category, presence: true, :case_sensitive => false, :scope => [:user_id], length: {minimum: 3}
  validates :substances, presence: true, length: {minimum: 3}
  #validates :ingredients, format: { with: /;/, :message => "substances must be seperate by a ';'" }
  #validates :substances, format: { with: /;+/, :message => "must end with or be seperated by a ';'" }
  #Match any characters as few as possible until a ";" is found, without counting the ";".
  validates :substances, format: { with: /.+?(?=;)/, :message => "must end with or be seperated by a ';'" }


  #The model should be able to answer the question "Can user x do y to this object?"
  #When you write regular methods in the model those methods are all instance methods.  
  #In other words def some_method will be a method available on each retrieved record

  # After allergen has been created or updated (and saved) check all products for
  # this allergen
  after_save do |allergen|
    if Product.any?
      Product.find_each {|product| check_for_allergens(product)}
    end
  end 

end