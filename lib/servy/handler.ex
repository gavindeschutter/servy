defmodule Servy.Handler do

  @moduledoc "Handles HTTP reqeusts."

  alias Servy.Conv

  @pages_path Path.expand("../../pages/", __DIR__)
  import Servy.BearController
  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]

  @doc "Transforms the request into a response."
  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

  # name-Baloo&type=Brown
  def route(%Conv{ method: "POST", path: "/bears" } = conv) do
    Servy.BearController.create(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/about" } = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears" } = conv) do
    Servy.BearController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears/" <> id } = conv) do
    params = Map.put(conv.params, "id", id)

    Servy.BearController.show(conv, params)
  end

  def route(%Conv{ method: "GET", path: "/about" } = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ method: "DELETE", path: "/bears/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)

    Servy.BearController.show(conv, params)
  end

  def handle_file({ :ok, content }, conv) do
    %{ conv | status: 200, resp_body: content }
  end

  def handle_file({ :error, :enoent }, conv) do
    %{ conv | status: 404, resp_body: "File not found" }
  end

  def handle_file({ :error, reason  }, conv) do
    %{ conv | status: 400, resp_body: "File error: #{reason}" }
  end

  # def route(%{ method: "GET", path: "/about" } = conv) do
  #   file =
  #     Path.expand("../../pages/", __DIR__)
  #     |> Path.join("about.html")

  #   case File.read(file) do
  #     { :ok, content } ->
  #       %{ conv | status: 200, resp_body: content }

  #     { :error, :enoent } ->
  #       %{ conv | status: 404, resp_body: "File not found" }

  #     { :error, reason } ->
  #       %{ conv | status: 400, resp_body: "File error: #{reason}" }
  #   end
  # end

  def route(%Conv{ path: path } = conv) do
    %{ conv | status: 404, resp_body: "No #{path} here!" }
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

response = Servy.Handler.handle(request)
IO.puts response