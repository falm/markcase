#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: ENV['MAIL_ADD']

  def password_reset(user)
    @user = user
    @url = edit_password_reset_url(@user.password_reset_token,host: default_url_options[:host])
    mail to: user.email, subject: '您在MarkCase上重置密码的确认邮件'
  end
end
