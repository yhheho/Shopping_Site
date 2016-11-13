defmodule ShoppingSite.Mailer do
  use Bamboo.Mailer, otp_app: :shopping_site

  # use Mailgun.Client,
  #   domain: Application.get_env(:shopping_site, :mailgun_domain),
  #   key: Application.get_env(:shopping_site, :mailgun_key)

  # @from "info@example.com"

  # def send_welcome_text_email(email) do
  #   send_email to: email,
  #              from: @from,
  #              subject: "Welcome!",
  #              text: "Welcome to MyApp!"
  # end

  # def send_welcome_html_email(email) do
  #   send_email to: email,
  #              from: @from,
  #              subject: "Welcome!",
  #              html: "<strong>Welcome to MyApp</strong>"
  # end

end
