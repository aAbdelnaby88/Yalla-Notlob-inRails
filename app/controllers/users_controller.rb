class UsersController < ApplicationController
    require 'bcrypt'
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

    def signup
        @user = User.new
    end

    # Sign up users.
    def signup_form
        user_full_name = params['user_full_name'].to_s()
        user_email = params['user_email_address'].to_s()
        user_password = params['user_password'].to_s()
        user_confirmation_password = params['user_confirmation_password'].to_s()

        # checking the vlidation of the email and the password and if true create a new user.
        if ((user_password == user_confirmation_password) != nil)
            my_password = BCrypt::Password.create("my password")#=>
            @user = User.create(name: user_full_name, email: user_email, password: my_password)
            if @user.errors.any?
                render 'users/signup'
            else
                redirect_to :groups
            end 
        else
            render 'users/signup'
        end
    end

    def groups
    end

    # validating the email(regex for the email, and if the email exists.)
    # def valid_email(user_email)
    #     @user_email = user_email
    #     if @user_email.match(/\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    #         is_user_exist = User.where(email: @user_email)
    #         # if returned an object from the database.
    #         if is_user_exist.length > 0
    #             return false;
    #         else # if there is no returned object.
    #             return true
    #         end
    #     else # if the email is not a valid email.
    #         return false;
    #     end
    # end

    # # validating the password if they're matching.
    # def valid_password(password, conf_password)
    #     @password = password
    #     @conf_password = conf_password
    #     if (@password == @conf_password)
    #         return true
    #     else
    #         return false
    #     end
    # end
end
