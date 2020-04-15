# frozen_string_literal: true

class UsersController < ApplicationController
  def signin_form
    user_email = params[:user_email]
    password = params[:user_password]

    # if a valid entered data by the user.
    if !user_email.empty? && !password.empty?
      is_regestered_user = User.where(email: user_email, password: password)
      # if returned user object
      unless is_regestered_user.empty?
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
    user_full_name = params['user_full_name'].to_s
    user_email = params['user_email_address'].to_s
    user_password = params['user_password'].to_s
    user_confirmation_password = params['user_confirmation_password'].to_s

    # checking the vlidation of the email and the password and if true create a new user.
    if valid_email(user_email) && valid_password(user_password, user_confirmation_password)
      User.create(name: user_full_name, email: user_email, password: user_password)
      render 'users/signed_up_success'
      nil
    else
      puts 'Error from the validating email'
      render 'users/signed_up_error'
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
