defmodule Servy.Bear do
  defstruct id: nil,
            name: "",
            type: "",
            hibernating: false

  def is_grizzly?(bear) do
    bear.type == "Grizzly"
  end

  def order_asc_by_name(b1, b2) do
    bear1.name <= bear2.name
  end
end