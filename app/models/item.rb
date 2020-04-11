class Item < ApplicationRecord
  belongs_to :order_user
  belongs_to :order
  belongs_to :user

  def order
    Order.where(order_user: self.order_user)
  end

  def user
    User.where(order_user: self.order_user)
  end

end
