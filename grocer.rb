def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do
    if  collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  arr = []
  i = 0
  while i < cart.length do
    obj = find_item_by_name_in_collection(cart[i][:item], arr)
    if obj != nil
      obj[:count] += 1
    else
      obj = {
            :item => cart[i][:item],
            :price => cart[i][:price],
            :clearance => cart[i][:clearance],
            :count => 1
            }
      arr << obj
    end
  i += 1  
  end
  return arr
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < coupons.length do
      cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
      couponed_item_name = "#{coupons[i][:item]} W/COUPON"
      cart_item_wih_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
      if cart_item && cart_item[:count] >= coupons[i][:num]
        if cart_item_wih_coupon
          cart_item_wih_coupon[:count] += coupons[i][:num]
          cart_item[:count] -= coupons[i][:num]
        else
          cart_item_wih_coupon = {
              :item => couponed_item_name,
              :price => coupons[i][:cost] / coupons[i][:num],
              :count => coupons[i][:num],
              :clearance => cart_item[:clearance]
                                  }
          cart << cart_item_wih_coupon
          cart_item[:count] -= coupons[i][:num]
        end
      end
    i += 1
  end
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.length do
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.20)).round(2)
    end
    i += 1
  end
  return cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  i = 0
  while i < final_cart.length do
      total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
  end
  if total > 100
      total -= (total * 0.10)
  end
    return total
end
