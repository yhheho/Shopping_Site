defmodule ShoppingSite.MailerTest do
  use ExUnit.Case
  use Bamboo.Test

  test "sends welcome email" do
    email = ShoppingSite.Email.welcome_text_email("yhheho@gmail.com")

    email |> ShoppingSite.Mailer.deliver_now
    assert_delivered_email ShoppingSite.Email.welcome_text_email("yhheho@gmail.com")
  end

end
