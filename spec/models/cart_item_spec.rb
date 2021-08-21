require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "每個 Cart Item 都可以計算它自己的金額（小計）" do
    p1 = Product.create(title: "七龍珠", price: 80)
    p2 = Product.create(title: "JOJO", price: 200)

    cart = Cart.new
    3.times { cart.add_item(p1.id) }
    4.times { cart.add_item(p2.id) }
    2.times { cart.add_item(p1.id) }
    
    expect(cart.items.first.price).to be 400
    expect(cart.items.second.price).to be 800

  end
  it "可以計算整台購物車的總消費金額" do 
    p1 = Product.create(title: "七龍珠", price: 80)
    p2 = Product.create(title: "JOJO", price: 200)

    cart = Cart.new
    3.times { 
      cart.add_item(p1.id)
      cart.add_item(p2.id)
    }

    expect(cart.total_price).to be 840
  end  
  it "特別活動可能可搭配折扣（例如誕節的時候全面打 9 折，或是滿額滿千送百）" do
    p1 = Product.create(title: "七龍珠", price: 80)
    p2 = Product.create(title: "JOJO", price: 200)

    cart = Cart.new
    3.times { 
      cart.add_item(p1.id)
      cart.add_item(p2.id)
    }

    expect(cart.discount(0.1)).to be 756
    expect(cart.rebate(500, 100)).to be 740
    expect(cart.rebate(1000, 100)).to be 840
  end
end
