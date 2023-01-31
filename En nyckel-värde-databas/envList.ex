defmodule EnvList do

  def new() do
    []
  end

  def add([],key,value) do
    [{key,value}]
  end
  def add([{key, _}| map],key,value) do
    [{key,value} | map]
  end
  def add([map|rest],key,value) do
    [map | add(rest, key,value)]
  end

  def lookup([],key) do
    {key, nil}
  end
  def lookup([{key,value} | _],key) do
    {key, value}
  end
  def lookup([_ | rest],key) do
    lookup(rest,key)
  end

  def remove([],_) do
    []
  end
  def remove([{key,_}|rest],key ) do
    rest
  end
  def remove([map|rest],key) do
    [map | remove(rest,key)]
  end


end
