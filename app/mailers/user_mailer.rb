class UserMailer < ActionMailer::Base
  default from: "myheroku.project@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  
  def user_greet(user)
    @user = user
    mail :to => user.email, :subject => "Welcome"
  end
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
