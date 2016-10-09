defmodule ShoppingSite.Admin.UserView do
  use ShoppingSite.Web,   :view

  def show_authority(user) do
    if user.admin do
      "Admin"
    else
      "normal user"
    end
  end

  def is_admin(user) do
    user.admin
  end
end
