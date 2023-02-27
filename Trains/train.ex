defmodule Train do

  def take([],_) do [] end
  def take(_, 0) do [] end
  def take([head|tail],n) do [head|take(tail,n-1)] end

  def drop([],_) do [] end
  def drop(train, 0) do train end
  def drop([_|tail],n) do drop(tail,n-1) end

  def append(t1,t2) do t1 ++ t2 end

  def member([],_) do :false end
  def member([y|_], y) do :true end
  def member([_|tail],y) do member(tail,y) end

  def position([],_) do :nil end
  def position([y|_],y) do 1 end
  def position([_|tail],y) do position(tail,y) + 1 end

  def split(train,y) do
    {take(train,position(train,y)-1),drop(train,position(train,y))}
  end

  def main([],n) do {n,[],[]} end

  def main(trains,0) do {0,trains,[]} end

  def main([head|tail],n) do
    {k,remain,taken} = main(tail,n)
    if (k == 0) do
      {k,[head|remain],taken}
    else
      {k - 1, remain,[head|taken]}
    end
  end

end
