defmodule Servy.BearController do

  alias Servy.Wildthings
  alias Servy.Bear

  @templates_path Path.expand("../../templates/", __DIR__)

  defp render(conv, template, bindings \\ []) do
    @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)
  end

  def index(conv) do
    bears = 
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    %{ conv | status: 200,
              resp_body: render(conv, "index.eex", [bears: bears]) }
  end

  def show(conv, %{ "id" => id }) do
    bear = Wildthings.get_bear(id)

    %{ conv | status: 200, resp_body: render(conv, "show.eex", [bear: bear]) }
  end

  def create(conv, %{ "name" => name, "type" => type }) do
    %{ conv | status: 201,
              resp_body: "Create a #{type} bear named #{name}!" }
  end

  def delete(conv, _params) do
    %{ conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end
end
