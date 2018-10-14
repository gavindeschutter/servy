defmodule HandlerTest do
  use ExUnit.Case, async: true
  
  import Servy.Handler, only: [handle: 1]

  test "GET /wildthings" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """
  end

  test "DELETE /bears" do
    request = """
    DELETE /bears/1 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 403 Forbidden\r
    Content-Type: text/html\r
    Content-Length: 29\r
    \r
    Deleting a bear is forbidden!
    """
  end



  # """

  # request = """
  # GET /bears HTTP/1.1
  # Host: example.com
  # User-Agent: ExampleBrowser/1.0
  # Accept: */*

  # """

  # response = Servy.Handler.handle(request)

  # IO.puts response

  # request = """
  # GET /bigfoot HTTP/1.1
  # Host: example.com
  # User-Agent: ExampleBrowser/1.0
  # Accept: */*

  # """

  # response = Servy.Handler.handle(request)

  # IO.puts response

  # request = """
  # GET /bears/1 HTTP/1.1
  # Host: example.com
  # User-Agent: ExampleBrowser/1.0
  # Accept: */*

  # """

  # response = Servy.Handler.handle(request)
  # IO.puts response

  # request = """
  # GET /wildlife HTTP/1.1
  # Host: example.com
  # User-Agent: ExampleBrowser/1.0
  # Accept: */*

  # """

  # response = Servy.Handler.handle(request)
  # IO.puts response

  # request = """
  # GET /about HTTP/1.1
  # Host: example.com
  # User-Agent: ExampleBrowser/1.0
  # Accept: */*

  # """

  # response = Servy.Handler.handle(request)

  # IO.puts response

  # request = """
  # POST /bears HTTP/1.1
  # Host: example.com
  # User-Agent: ExampleBrowser/1.0
  # Accept: */*
  # Content-Type: application/x-www-form-urlencoded
  # Content-Length: 21

  # name=Baloo&type=Brown
  # """

  # response = Servy.Handler.handle(request)
  # IO.puts response

  # request = """
  # POST /bears HTTP/1.1
  # Host: example.com
  # User-Agent: ExampleBrowser/1.0
  # Accept: */*
  # Content-Type: application/x-www-form-urlencoded
  # Content-Length: 21

  # name=Baloo&type=Brown
  # """

  # response = Servy.Handler.handle(request)
  # IO.puts response

  # response = Servy.Handler.handle(request)
  # IO.puts response
end