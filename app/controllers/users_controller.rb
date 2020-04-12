class UsersController < ApplicationController
    def signin
    end

    # Sign up users.
    def signup
        user_full_name = params['user_full_name'].to_s()
        user_email = params['user_email_address'].to_s()
        user_password = params['user_password'].to_s()
        user_confirmation_password = params['user_confirmation_password'].to_s()

        # checking the vlidation of the email and the password.
        if valid_email(user_email) && valid_password(user_password, user_confirmation_password)
            User.create(name: user_full_name, email: user_email, password: user_password)
            render 'users/signed_up_success'
        else
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
end
