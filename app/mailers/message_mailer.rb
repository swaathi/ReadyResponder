class MessageMailer < ActionMailer::Base
  default from: "records@billericaema.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.callout.subject
  #
  def callout(message, recipient_address)
    @message = message

    mail to: recipient_address, subject: message.subject

  end

  # I should also define a 'we miss you' mailer, 
  # and perhaps roll the 'certification mailer expiring' 
  # mailer into here.
end
