require 'spec_helper'

describe Dish do
  it "valid" do
    Dish.make.should be_valid
  end

  it "not valid if name attr is blank" do
    Dish.make(:name => nil).should_not be_valid
  end

  it "not valid if price is blank" do
    Dish.make(:price => nil).should_not be_valid
  end

  it "not valid if price lower then 10" do
    Dish.make(:price => 9).should_not be_valid
  end

  it "not valid if menu is blank" do
    Dish.make(:menu => nil).should_not be_valid
  end

  describe "many-to-many relation with DishTag" do
    let(:dish) { Dish.make! }
    let(:tag) { DishTag.make! }

    it "adds new tag to tag list" do
      expect { dish.tags << tag }.to change(dish.tags, :count).from(0).to(1)
    end

    it "don't add same tag twice" do
      expect { 2.times { dish.tags << tag } }.to change(dish.tags, :count).from(0).to(1)
    end
  end
end
