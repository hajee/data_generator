defmodule Entity do
  defstruct 
    name: nil,        # name of the entity
    attributes: [],   # attributes in the entity
    closed: false,    # entity closed for further attributes e.g. end found in definition
end
