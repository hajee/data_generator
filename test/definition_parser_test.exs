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

  @entities [
    %Entity{name: "person"},
    %Attribute{name: "first_name", definition: "string(50)"},
    "end",
    %Entity{name: "city"},
    %Attribute{name: "name", definition: "string(50)" },
    %Attribute{name: "id", definition: "integer" },
    "end"
  ]

  @entities_without_end [
    %Entity{name: "person"},
    %Attribute{name: "first_name", definition: "string(50)"},
    %Entity{name: "city"},
    "end"
  ]


  @parsed_entities [
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

  test "entitize transforms it into a list of structs" do
    assert entitize(@tokens) == {:ok, @entities}
  end

  test "parse transforms it into a list of entities" do
    assert parse(@entities) == {:ok, @parsed_entities}
  end

  test "parse error when end is forgotten" do
    assert parse(@entities_without_end) == {:error, "entity definition must close with an end"}
  end


end
