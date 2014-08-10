defmodule DefinitionParser do


# def definitions(content) do
#    tokenize(content)    # put into a list of tokens
#     |> entitize         # put tokens into list f entities        
#
#
#
# end
  
  def tokenize(definition_string) do
    String.split(definition_string)
  end


  def entitize(tokens) do
    _entitize(tokens, [])
  end

  # End condition
  defp _entitize([], result) do
    Enum.reverse(result)
  end

  # found an entity
  defp _entitize(["entity", name | rest], result) do
    _entitize(rest, [ %Entity{name: name} | result])
  end

  # found an end
  defp _entitize(["end" |rest], result) do
    _entitize(rest, [ "end"| result])
  end

  # found an attribute pair
  defp _entitize([name, definition | rest], result) do
    _entitize(rest, [ %Attribute{name: name, definition: definition} | result])
  end


  def parse( list) do
    _parse( list, [])
  end

  # end condition
  defp _parse( [], result) do
    Enum.reverse(result)
  end

  # found an entity 
  defp _parse([%Entity{} = entity| rest], result) do
    _parse(rest, [entity| result])
  end

  # found an attribute 
  defp _parse([%Attribute{} = attribute| rest], [%Entity{} = entity| result_tail]) do
    new_attributes = Enum.sort([attribute | entity.attributes])
    _parse(rest, [%{entity | attributes: new_attributes} | result_tail] )
  end

  # found an end
  defp _parse(["end"| rest], result) do
    _parse(rest, result )
  end


end

