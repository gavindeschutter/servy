defmodule Servy.BearController do

  alias Servy.Wildthings

  def index(conv) do
    bears = Wildthings.list_bears()

    # TODO: Transform bears into an HTML list
    response = bears
               |> Enum.map(fn(bear) -> "<li>#{bear.name}</li>" end)
               |> Enum.join("")

    %{ conv | status: 200, resp_body: response }
  end

  def show(conv, %{ "id" => id }) do
    %{ conv | status: 200, resp_body: "Bear #{id}" }
  end

  def create(conv, %{ "name" => name, "type" => type }) do
    %{ conv | status: 201,
              resp_body: "Create a #{type} bear named #{name}!" }
  end
end
