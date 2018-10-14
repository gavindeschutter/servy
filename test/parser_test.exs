defmodule ParserTest do
  use ExUnit.Case
  doctest Servy.Parser

  alias Servy.Parser

  describe "parse_headers" do
    test "parses a list of header fields to a map" do
      header_lines = ["A: 1", "B: 2"]

      headers = Parser.parse_headers(header_lines)

      assert(headers == %{"A" => "1", "B" => "2"})
    end
  end
end
