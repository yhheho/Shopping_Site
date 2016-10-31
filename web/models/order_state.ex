defmodule ShoppingSite.OrderState do
  use Fsm, initial_state: :order_placed

  # order_placed
  # paid
  # shipping
  # shipped
  # order_cancelled
  # good_returned


  @behaviour Ecto.Type
  def type, do: :string

  def cast(fsm) do  #receive any type, output custom type

  end

  def load() do  #receive db type, ouptput custon type

  end

  def dump() do  #receive custom type, output db type

  end

  # 想要可以直接使用 OrderState.make_payment 這樣（自動將state轉成 paid）
  # state = OrderState.new
  # state |> OrderState.make_payment
  # state.state => :paid !!
  # => save this state in Repo !!

  # ===> no, write a pattern matching instead


  defstate order_placed do
    defevent make_payment do
      next_state(:paid)
    end
  end

  defstate paid do
    defevent ship do
      next_state(:shipping)
    end
  end

  defstate shipping do
    defevent deliver do
      next_state(:shipped)
    end
  end

  defstate shipped do
    defevent return_good do
      next_state(:good_returned)
    end
  end

  defstate order_placed do
    defevent cancell_order do
      next_state(:order_cancelled)
    end
  end

  defstate paid do
    defevent cancell_order do
      next_state(:order_cancelled)
    end
  end

end
