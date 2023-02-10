defmodule Aoc1 do
  def adventofcode1 do data() end
  def data() do Enum.max(test(File.read!("data.txt"))) end

  def test(data) do test2(String.split(data,"\r\n\r\n")) end

  def test2([]) do [] end
  def test2([head|rest]) do sort([sum(String.split(head,"\r\n"))|(test2(rest))]);

  end

  def sum([]) do 0 end
  def sum([head|tail]) do String.to_integer(head) + sum(tail) end

  def sort(list) do Enum.sort(list, :desc) end

end
