class UsersController < ApplicationController
    
    def signin_form
        user_email = params[:user_email]
        password = params[:user_password]

        # if a valid entered data by the user.
        if (user_email.length > 0) && (password.length > 0)
            is_regestered_user = User.where(email: user_email, password: password)
            # if returned user object
            if is_regestered_user.length > 0
                render 'users/singed_in_success'
                return is_regestered_user
            end
            render 'users/signed_in_error'
        else
            render 'users/signed_in_error'
        end
    end

    # Sign up users.
    def signup_form
        user_full_name = params['user_full_name'].to_s()
        user_email = params['user_email_address'].to_s()
        user_password = params['user_password'].to_s()
        user_confirmation_password = params['user_confirmation_password'].to_s()

        # checking the vlidation of the email and the password and if true create a new user.
        if valid_email(user_email) && valid_password(user_password, user_confirmation_password)
            User.create(name: user_full_name, email: user_email, password: user_password)
            render 'users/signed_up_success'
            return 
        else
            puts "Error from the validating email"
            render 'users/signed_up_error'
        end
    end

    def groups
    end

    # validating the email(regex for the email, and if the email exists.)
    def valid_email(user_email)
        @user_email = user_email
        if @user_email.match(/\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
            is_user_exist = User.where(email: @user_email)
            # if returned an object from the database.
            if is_user_exist.length > 0
                return false;
            else # if there is no returned object.
                return true
            end
        else # if the email is not a valid email.
            return false;
        end
    end

    # validating the password if they're matching.
    def valid_password(password, conf_password)
        @password = password
        @conf_password = conf_password
        if (@password == @conf_password)
            return true
        else
            return false
        end
    end


    def friends
        @u1=User.find_by_id(1)
        @friends_list = @u1.friends
    end

    def addnewFriend    
        newFriendEmail =params[:friend_email]+".com"
        @u1=User.find_by_id(1)
        @friends_list = @u1.friends
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
                Friendship.create(:friend_a_id=>@u1.id,:friend_b_id=>friend.id)
            end
        else
            flash[:alert]= "Enter Valid Email!!"
        end
    end

    def deleteFriend
        f = Friendship.where(friend_a_id: 1, friend_b_id: params[:friend_id]).first()
        Friendship.delete(f.id)
        redirect_to :friends
    end

end
