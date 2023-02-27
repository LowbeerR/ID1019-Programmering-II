defmodule Shunt do

  def find([],[]) do [] end
  def find([],_) do [] end
  def find(_,[]) do [] end
  def find(xs,[y|ys]) do

    {hs,ts} = Train.split(xs,y)
    [{:one, length(ts)+1}, {:two, length(hs)}, {:one, -length(ts)-1}, {:two, -length(hs)} | find(Train.append(ts,hs),ys)]
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
    [{:one, length(ts)+1}, {:two, length(hs)}, {:one, -(length(ts)+1)}, {:two, -length(hs)} | few(Train.append(ts,hs),ys)]
    end
  end

  def rules([]) do [] end
  def rules([head | rest]) do
    case head do
      {_, 0} -> rules(rest)
      {:one, n} -> case rest do
        [{:one, m}|rest2] -> [{:one, n + m} | rules(rest2)]
        _ -> [{:one, n}| rules(rest)]
      end
      {:two, n} -> case rest do
        [{:two, m}|rest2] -> [{:two, n + m} | rules(rest2)]
        _ -> [{:two, n} | rules(rest)]
      end
      _ -> :nil
    end
  end
  def rules(list) do list end


  def compress(ms) do
    ns = rules(ms)
    if ns == ms do
    ms
    else
    compress(ns)
    end
    end
end
