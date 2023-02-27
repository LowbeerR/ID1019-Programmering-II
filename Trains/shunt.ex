defmodule Shunt do

  def find([],[]) do [] end
  def find([],_) do [] end
  def find(_,[]) do [] end
  def find(xs,[y|ys]) do

    {hs,ts} = Train.split(xs,y)
    [{:one, length(ts)+1}, {:two, length(hs)}, {:one, -length(ts)-1}, {:two, -length(hs)} | find(Train.append(hs,ts),ys)]
  end

  def few([],[]) do [] end
  def few([],_) do [] end
  def few(_,[]) do [] end

  def few(xs,[y|ys]) do
    case Train.position(xs,y) == Train.position([y|ys],y) do
      :true ->
        {hs,ts} = Train.split(xs,y)
        few(Train.append(hs,ts),ys)
      :false ->
    {hs,ts} = Train.split(xs,y)
    [{:one, length(ts)+1}, {:two, length(hs)}, {:one, -length(ts)-1}, {:two, -length(hs)} | few(Train.append(hs,ts),ys)]
    end
  end
end
