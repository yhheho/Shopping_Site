defmodule ShoppingSite.StateChangeController do
  use ShoppingSite.Web, :controller

  def ship(order) do
    state = order.fsm_state

    case state do
      "paid" ->
        Ecto.Changeset.change(order, %{fsm_state: "shipping"})
          |> Repo.update
    end
  end

  def deliver(order) do
    state = order.fsm_state

    case state do
      "shipping" ->
        Ecto.Changeset.change(order, %{fsm_state: "shipped"})
          |> Repo.update
    end
  end

  def return_good(order) do
    state = order.fsm_state

    case state do
      "shipped" ->
        Ecto.Changeset.change(order, %{fsm_state: "good_returned"})
          |> Repo.update
    end
  end

  def cancell_order(order) do
    state = order.fsm_state

    case state do
      "paid" ->
        Ecto.Changeset.change(order, %{fsm_state: "order_cancelled"})
          |> Repo.update
      "order_placed" ->
        Ecto.Changeset.change(order, %{fsm_state: "order_cancelled"})
          |> Repo.update
    end
  end


end
