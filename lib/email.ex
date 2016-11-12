defmodule ShoppingSite.Email do
  use Bamboo.Phoenix,   view: ShoppingSite.EmailView

  def welcome_text_email(email_address) do
    new_email
      |> to(email_address)
      |> from("us@example.com")
      |> subject("Welcome!")
      |> text_body("Welcome to ShoppingSite!")
  end

end
