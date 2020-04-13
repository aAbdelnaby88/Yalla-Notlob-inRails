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

    def signup_validation(user_name, user_password, user_email)
        begin
            validates :user_name, presence: true
            validates :user_password, presence: true
            validates :user_email, confirmation: true
            
            if User.create(name: user_name, email: user_password, password: user_email)
                return true
            else
                return false
            end
        rescue StandardError => e
            return false
        end
    end
    
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
