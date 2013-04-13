class UserMailer < ActionMailer::Base
  default from: ENV['GMAIL_ADD']

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    @url = edit_password_reset_url(@user.password_reset_token,host: 'localhost')
    mail to: user.email, subject: "您在MarkCase上重置密码的确认邮件" 
  end
end
