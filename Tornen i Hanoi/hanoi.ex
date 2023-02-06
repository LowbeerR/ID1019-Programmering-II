defmodule Hanoi do

  def hanoi(0, _, _, _) do nil end
  def hanoi(1, a, _, c) do {:move, a, c} end
  def hanoi(2, a, b, c) do
    [{:move,a , b}, {:move, a, c}, {:move, b, c}]
  end

  def hanoi(n, a, b, c) do
    #move tower of size n-1
    hanoi(n-1, a, c, b) ++
    #[ move one disc ... ]
    [hanoi(1, a, b, c)] ++
    # move tower of size n-1
    hanoi(n-1, b, a, c)
   end
end
