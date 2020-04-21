require 'aws-sdk-s3' 
require 'securerandom'

class OrdersController < ApplicationController

    def upload_image_to_s3
        file_name = SecureRandom.urlsafe_base64
        upload_file = '/home/muhammad/Downloads/32.png'

        s3 = Aws::S3::Resource.new
        obj = s3.bucket('yalla-notlob').object(file_name)
        obj.upload_file(upload_file)

        url = obj.public_url
    end

    def addorder
        
    end


    def addNewOrder
        
    end

    def addOrderFriends
        name = params[:friend_email]
        p "hi there"
        p name
        @friends_list = User.find_by_id(@u1['id']).friends
        found= false
        if newFriendEmail.length > 0
            @friends_list.each do |f|
                if f.email == newFriendEmail
                    found=true
                    break
                end
            end

            if found
                flash[:alert]= "Already Friends!!"
            else
                friend=User.find_by_email(newFriendEmail)
                Friendship.create(:friend_a_id=>@u1['id'],:friend_b_id=>friend.id)
            end
        else
            flash[:alert]= "Enter Valid Email!!"
        end
        

    end


    def order 
    end

    def orderdetails
    end
end
