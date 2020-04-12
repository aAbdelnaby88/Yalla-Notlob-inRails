class UsersController < ApplicationController
    def signin
    end

    def signup
        user_full_name =params['user_full_name'].to_s()
        user_email = params['user_email_address'].to_s()
        user_password = params['user_password'].to_s()
        user_confirmation_password = params['user_confirmation_password'].to_s()

        if valid_email(user_email) && valid_password(user_password, conf_password)
            puts "Done sign up!"
        else
            puts "Error, signing up!"
        end
    end

    def groups
    end

    def valid_email(email)
        @email = email
        if email.match(/\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
            return true;
        else
            return false;
        end
    end

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
