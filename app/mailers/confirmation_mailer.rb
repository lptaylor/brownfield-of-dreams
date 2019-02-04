class ConfirmationMailer < ApplicationMailer
  def success(current_user)
    @user = current_user
    mail(to: @user.email, subject: "Activate Turing Tutorials Account!")
  end
end
