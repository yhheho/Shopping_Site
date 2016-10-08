defmodule ShoppingSite.Admin.ProductView do
  use ShoppingSite.Web,   :view

  def present?(photo) do
    photo.file_name != ""
  end
end
