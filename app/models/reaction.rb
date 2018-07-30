class Reaction < ApplicationRecord
  belongs_to :allergen
  belongs_to :product
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
end