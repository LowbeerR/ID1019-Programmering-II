defmodule EnvTree do

  def new() do
    nil
  end

  def add(nil, key, value) do
    {:node, key, value, nil, nil}
  end
  def add({:node, key, _, left, right}, key, value) do
    {:node, key, value, left, right}
  end
  def add({:node, k, v, left, right}, key, value) when key < k do
    {:node, k, v, add(left,key,value), right}
    #... return a tree that looks like the one we have
    #but where the left branch has been updated ...
  end
  def add({:node, k, v, left, right}, key, value) do
    #... same thing but instead update the right banch
    {:node, k, v, left ,add(right,key,value)}
  end

  def lookup(nil,key) do
    {key,nil}
  end
  def lookup({:node, key, value, _, _}, key) do
    {key,value}
  end
  def lookup({:node, k, _, left, _}, key) when key < k do
    lookup(left,key)
  end
  def lookup({:node, _, _, right}, key) do
    lookup(right,key)
  end
  def lookup(_,key) do
    {key, nil}
  end

  #remove
  def remove(nil, _) do
  nil
  end
  def remove({:node, key, _, nil, right}, key) do
    right
  end
  def remove({:node, key, _, left, nil}, key) do
    left
  end
  def remove({:node, key, _, left, right}, key) do
    {key, value, rest} = leftmost(right)
    {:node, key, value, left, rest}
  end
  def remove({:node, k, v, left, right}, key) when key < k do
    {:node, k, v, remove(left,key), right}
  end
  def remove({:node, k, v, left, right}, key) do
    {:node, k, v, left, remove(right,key)}
  end
  def leftmost({:node, key, value, nil, rest}) do
    {key,value,rest}
  end
  def leftmost({:node, k, v, left, right}) do
    {key,value, rest} = leftmost(left)
    {key, value, {:node, k, v, rest, right}}
  end
end
