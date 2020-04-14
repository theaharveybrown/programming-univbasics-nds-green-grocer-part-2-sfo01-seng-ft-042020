require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)

  index = 0 
  while index < cart.length do 
    item_name = cart[index][:item]

    coupon_match = find_item_by_name_in_collection(item_name, coupons)
    coupon_hit = !!coupon_match
    eligible = coupon_hit && coupon_match[:num] <= cart[index][:count]
    
    if eligible
      discount_price = (coupon_match[:cost] / coupon_match[:num]).round(2)
      cart[index][:count] -= coupon_match[:num]
      cart << { item: "#{coupon_match[:item]} W/COUPON", 
                price: discount_price, 
                clearance: cart[index][:clearance],
                count: coupon_match[:num]
              }
    end 
    index += 1 
  end 
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  discounted_cart = []
  cart.each do |item|
    if item[:clearance]
      discount_item = item 
      discount_item[:price] = (item[:price] * 0.8).round(2)
      discounted_cart << discount_item
    else 
      discounted_cart << item
    end 
  end 
  discounted_cart
end

def checkout(cart, coupons)
  con_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(con_cart, coupons)
  final_cart = apply_clearance(coup_cart)
  total = 0 
  final_cart.each do |item|
    puts "price: #{item[:price] * item[:count]}"
    price = item[:price] * item[:count]
    total += price
  end 

  if total >= 100 
    total = 0.9 * total
  end
  total = total.round(2)
  total
end

