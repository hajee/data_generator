defmodule DefinitionParserTest do
  use ExUnit.Case

  import DefinitionParser

  @definition """
  entity person
    first_name    string(50)
  end

  entity city
    name          string(50)
    id            integer
  end
  """

  @tokens [
    "entity",
    "person",
    "first_name",
    "string(50)",
    "end",
    "entity",
    "city",
    "name",
    "string(50)",
    "id",
    "integer",
    "end"
  ]

  @tokens_without_end [
    "entity",
    "person",
    "first_name",
    "string(50)",
    "entity",
    "city",
    "end"
  ]


  @parsed [
    %Entity{name: "person", attributes: [
      %Attribute{name: "first_name", definition: "string(50)"}
    ]},
    %Entity{name: "city", attributes: [
      %Attribute{name: "id", definition: "integer" },
      %Attribute{name: "name", definition: "string(50)" },
    ]}
  ]


  test "tokenize returns all strings as tokens" do
    assert tokenize(@definition) == {:ok, @tokens}
  end

  test "parse transforms it into a list of structs" do
    assert parse(@tokens) == {:ok, @parsed}
  end

  test "parse error when end is forgotten" do
    assert parse(@tokens_without_end) == {:error, "entity definition must close with an end"}
  end


end
