class MessageMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.callout.subject
  #
  def callout(message)

    @message = message
    mail to: message.recipient
  end
end
