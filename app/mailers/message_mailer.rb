class MessageMailer < ActionMailer::Base
  default from: "callout@billericaema.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.callout.subject
  #
  def callout(notification, recipient, mailing_address)
    @message = notification
    @recipient = recipient

    mail to: mailing_address,
         subject: notification.subject
  end

  # I should also define a 'we miss you' mailer, 
  # and perhaps roll the 'certification mailer expiring' 
  # mailer into here.
end
