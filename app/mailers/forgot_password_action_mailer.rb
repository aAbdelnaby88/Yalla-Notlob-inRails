class ForgotPasswordActionMailer < ApplicationMailer
  def forgot_password(user_email)
    @user_email = user_email
    print `From the email function: #{@user_email} \n` 
    mail(:to => @user_email, :subject => "Forgot Password")
  end
end
