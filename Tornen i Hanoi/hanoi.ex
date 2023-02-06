defmodule Hanoi do

  def hanoi(0, _, _, _) do [] end

  def hanoi(n, a, b, c) do
    #move tower of size n-1
    hanoi(n-1, a, c, b) ++
    #[ move one disc ... ]
    [{:move, a, c}] ++
    # move tower of size n-1
    hanoi(n-1, b, a, c)
   end
end
