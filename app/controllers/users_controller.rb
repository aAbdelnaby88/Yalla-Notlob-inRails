class UsersController < ApplicationController
    require 'bcrypt'
    def signin_form
        user_email = params[:user_email]
        password = params[:user_password]
        encrypted_password = ""

        is_regestered_user = User.where(email: user_email).first

        # check the user's login password with the encrpted pass from the database.
        if BCrypt::Password.new(is_regestered_user.password) == password
            session[:logged_in_user] = is_regestered_user
            redirect_to :groups
        else
            render 'users/signin'
        end
    end

    def check_logged_in
        if session[:logged_in_user] != nil
            logged_in_user = session[:logged_in_user]
            return logged_in_user
        else
            return nil
        end
    end

    def log_out
        reset_session
        redirect_to :signin
    end

    # signin method for the html rendering
    def signin
        if check_logged_in == nil
            redirect_to :signin
        else
            redirect_to :groups
        end
    end

    # signup method for the html renderig
    def signup
        @user = User.new
        if check_logged_in == nil
            redirect_to :signup
        else
            redirect_to :groups
        end
    end

    # Sign up users.
    def signup_form
        user_full_name = params['user_full_name'].to_s()
        user_email = params['user_email_address'].to_s()
        user_password = params['user_password'].to_s()
        user_confirmation_password = params['user_confirmation_password'].to_s()

        # checking the vlidation of the email and the password and if true create a new user.
        if ((user_password == user_confirmation_password) != nil)
            my_password = BCrypt::Password.create(user_password)#=>
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
end
