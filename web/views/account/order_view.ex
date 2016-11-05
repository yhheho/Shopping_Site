defmodule ShoppingSite.Account.OrderView do
  use ShoppingSite.Web,   :view

  def generated_time(order) do
    order.inserted_at
  end

end
