defmodule DefinitionParser do

# def definitions(content) do
#    tokenize(content)    # put into a list of tokens
#     |> parse         # put tokens into list f entities        
#
#
#
# end
  @doc """

  Transform the input string into a list of string tokens

  """
  def tokenize(definition_string) do
    {:ok, String.split(definition_string)}
  end

  @doc """

  Transform a list of string tokens into a list of structs

  """
  def parse(tokens) do
    _parse(tokens, [])
  end

  defp _parse([], result),                                      do: {:ok, Enum.reverse(result)}
  defp _parse(["entity", name | rest], result),                 do: _parse([%Entity{name: name}| rest], result)
  defp _parse([%Entity{} = entity, "end"| rest], result),       do: _parse( rest, [entity| result])
  defp _parse([%Entity{name: name}, "entity"| rest], result),   do: {:error, "entity definition must close with an end"}

  defp _parse([%Entity{} = entity, name, definition | rest], result) do
    entity = _add_attribute_to_entity(entity, name, definition)
    _parse( [entity| rest], result)
  end


  defp _add_attribute_to_entity(entity, name, definition) do
    attribute = %Attribute{name: name, definition: definition}
    new_attributes = Enum.sort([attribute | entity.attributes])
    %{entity | attributes: new_attributes}
  end


end

