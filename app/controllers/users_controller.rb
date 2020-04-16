# frozen_string_literal: true

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
  end

  # Sign up users.
  def signup_form
    user_full_name = params['user_full_name'].to_s
    user_email = params['user_email_address'].to_s
    user_password = params['user_password'].to_s
    user_confirmation_password = params['user_confirmation_password'].to_s


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
  end

  def groups
    @group = Group.new
    @groups = Group.eager_load(:users).where(:user_id =>1)
  end

  def new_group
    @group = Group.new(params.require(:group).permit(:name))
    @group.user_id = 1
    if @group.save
      redirect_to :groups
    else
      @groups = Group.eager_load(:users).where(:user_id =>1)
      render :groups
    end

  end

  def delete_group
    Group.find(params[:id]).delete
    redirect_to :groups
  end

  def delete_group_user
    Group.find(params[:id]).users.delete(params[:user_id])
    redirect_to :groups
  end


  def add_group_user
    
    user = User.find(1)
    friend = user.friends.detect{|f| f.name.casecmp(params[:user_name]) == 0}
    p friend
    if friend
      Group.find(params[:id]).users << friend
    end
    redirect_to :groups
  end

  # validating the email(regex for the email, and if the email exists.)
  def valid_email(user_email)
    @user_email = user_email
    if @user_email.match(/\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      is_user_exist = User.where(email: @user_email)
      # if returned an object from the database.
      if !is_user_exist.empty?
        false
      else # if there is no returned object.
        true
      end
    else # if the email is not a valid email.
      false
    end
  end

  # validating the password if they're matching.
  def valid_password(password, conf_password)
    @password = password
    @conf_password = conf_password
    @password == @conf_password
  end

end
