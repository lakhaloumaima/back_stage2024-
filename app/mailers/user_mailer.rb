class UserMailer < ApplicationMailer
  default from: 'superadmin@gmail.com'


  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.lastname} <#{user.email}>"  ,  :subject => "Registration Confirmation")
  end


end
