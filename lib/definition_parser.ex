defmodule DefinitionParser do

import MultiDef

# def definitions(content) do
#    tokenize(content)    # put into a list of tokens
#     |> entitize         # put tokens into list f entities        
#
#
#
# end
  @doc """

  Transform the input string into a list of string tokens

  """
  def tokenize(definition_string) do
    String.split(definition_string)
  end


  @doc """

  Transform a list of string tokens into a list of structs

  """
  def entitize(tokens) do
    _entitize(tokens, [])
  end

  mdef _entitize do
    [], result                          -> Enum.reverse(result)
    ["entity", name | rest], result     -> _entitize(rest, [ %Entity{name: name} | result])
    ["end" |rest], result               -> _entitize(rest, [ "end"| result])
    [name, definition | rest], result   -> _entitize(rest, [ %Attribute{name: name, definition: definition} | result])
  end


  def parse( list) do
    _parse( list, [])
  end

  mdef _parse do
    [], result                          -> Enum.reverse(result)
    [%Entity{} = entity| rest], result  -> _parse(rest, [entity| result])

    [%Attribute{} = attribute| rest], [%Entity{} = entity| result_tail]
                                        -> _parse(rest, [_add_attribute_to_entity(entity, attribute) | result_tail])
    ["end"| rest], result               -> _parse(rest, result )
  end

  defp _add_attribute_to_entity(entity, attribute) do
    new_attributes = Enum.sort([attribute | entity.attributes])
    %{entity | attributes: new_attributes}
  end


end

