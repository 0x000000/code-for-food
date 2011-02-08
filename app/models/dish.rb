class Dish < ActiveRecord::Base
  belongs_to :menu
  has_and_belongs_to_many :tags, :class_name => 'DishTag', :uniq => true
  validates_presence_of :name, :price, :menu
  validates_numericality_of :price, :only_integer => true, :greater_than_or_equal_to => 10
end
