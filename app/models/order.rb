class Order < ApplicationRecord
  belongs_to :user

  enum meal: [ :breakfast, :lunch, :dinner ]
  enum status: [ :waiting, :finished, :cancelled ]

  has_many :order_user
  has_many :users, through: :order_user
  has_many :items
  def items
    Item.where(order_user: self.order_user)
  end

end
