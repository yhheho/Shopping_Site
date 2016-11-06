defmodule ShoppingSite.Admin.OrderView do
  use ShoppingSite.Web,   :view

  def generated_time(order) do
    order.inserted_at
  end

  def render_order_paid_state(order) do
    if order.is_paid do
      "Paid"
    else
      "Not paid"
    end
  end
end
