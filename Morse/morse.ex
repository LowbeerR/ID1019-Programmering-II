defmodule Morse do

  def encode_table(tree) do
    get_codes(tree,[])
  end

  def get_codes({_, :na, nil, nil},_) do [] end
  def get_codes({_, :na, left, nil}, code) do get_codes(left, [45 | code]) end
  def get_codes({_, :na, nil, right}, code) do get_codes(right, [46 | code]) end

  def get_codes({:node, :na, left, right}, code) do
    left = get_codes(left, [45 | code])
    right = get_codes(right, [46 | code])
    left ++ right
  end

  def get_codes({_, val, nil, nil}, code) do [{val, Enum.reverse([32 |code ])}] end
  def get_codes({_, val, left, nil}, code) do [{val, Enum.reverse([32 |code ])}] ++ get_codes(left, [45 | code]) end
  def get_codes({_, val, nil, right}, code) do [{val, Enum.reverse([32 |code ])}] ++ get_codes(right, [46 | code]) end

  def get_codes({:node, val, left, right}, code) do
    left = get_codes(left, [45 | code])
    right = get_codes(right, [46 | code])
    [{val, Enum.reverse([32 |code ])}] ++ left ++ right
  end

  def encode(text, table) do
    lst = Enum.map(text, fn(x) -> table_lookup(table,x) end)
     together(lst)
  end

  def table_lookup([], _) do [] end
  def table_lookup([head|tail], arg) do
    case head do
      {^arg, list} -> list
      {_,_} -> table_lookup(tail,arg)
    end
  end
  def table_lookup(_,_) do nil end

  def together([]) do [] end
  def together([head|tail]) do head ++ together(tail) end

  def decode([], _) do
    []
  end
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end
  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
      {char,rest}
      nil ->
      decode_char(seq, n+1, table)
    end
  end

  def morse() do
    {:node, :na,
    {:node, 116,
    {:node, 109,
    {:node, 111,
    {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
    {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
    {:node, 103,
    {:node, 113, nil, nil},
    {:node, 122,
    {:node, :na, {:node, 44, nil, nil}, nil},
    {:node, 55, nil, nil}}}},
    {:node, 110,
    {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
    {:node, 100,
    {:node, 120, nil, nil},
    {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
    {:node, 101,
    {:node, 97,
    {:node, 119,
    {:node, 106,
    {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
    nil},
    {:node, 112,
    {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
    nil}},
    {:node, 114,
    {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
    {:node, 108, nil, nil}}},
    {:node, 105,
    {:node, 117,
    {:node, 32,
    {:node, 50, nil, nil},
    {:node, :na, nil, {:node, 63, nil, nil}}},
    {:node, 102, nil, nil}},
    {:node, 115,
    {:node, 118, {:node, 51, nil, nil}, nil},
    {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
    end
end
