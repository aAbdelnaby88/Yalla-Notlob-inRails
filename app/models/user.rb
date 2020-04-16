class User < ApplicationRecord

    has_many :friend_requests_as_requestor, foreign_key: :requestor_id, 
    class_name: :FriendRequest   
    has_many :friend_requests_as_receiver , foreign_key: :receiver_id,
    class_name: :FriendRequest

    
    has_many :friendships_as_friend_a, foreign_key: :friend_a_id, 
    class_name: :Friendship  
    has_many :friendships_as_friend_b,foreign_key: :friend_b_id, 
    class_name: :Friendship   
    has_many :friend_as, through: :friendships_as_friend_b   
    has_many :friend_bs, through: :friendships_as_friend_a  


    has_many :groups

    has_many :order_user
    has_many :orders, through: :order_user
    
    has_many :items

    # has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true
    
    def items
      Item.where(order_user: self.order_user)
    end
  
    def friendships
        self.friendships_as_friend_a + self.friendships_as_friend_b
    end

    def friends
        self.friend_as + self.friend_bs
    end

end
