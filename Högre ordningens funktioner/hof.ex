defmodule Hof do
  #double
  def double([]) do [] end
  def double([head|tail]) do
    [head*2|double(tail)]
  end

  #five
  def five([]) do [] end
  def five([head|tail]) do
    [head+5 | five(tail)]
  end

  #animal
  def animal([]) do [] end
  def animal([head|tail]) do
    case head do
      :dog -> [:fido | animal(tail)]
      _ -> [head | animal(tail)]
    end
  end

  def double_five_animal([],_) do [] end
  def double_five_animal([head|tail], arg) do
    case arg do
    :double -> [head*2|double_five_animal(tail,arg)]
    :five -> [head+5 | double_five_animal(tail,arg)]
      :animal -> case head do
        :dog -> [:fido| double_five_animal(tail,arg)]
        _ -> [head| double_five_animal(tail,arg)]
      end
    end
  end

  def apply_to_all([],_) do [] end
  def apply_to_all([head|tail],func) do [func.(head)] ++ apply_to_all(tail, func) end

  def sum([]) do 0 end
  def sum([head|tail]) do head + sum(tail) end

  def fold_right([],base,_) do base end
  def fold_right([head|tail],base,f) do
    f.(head,fold_right(tail,base,f))
  end
  def fold_right([],_) do 0 end
  def fold_right([head|tail], f) do f.(head,fold_right(tail,f)) end

  def fold_left([],base,_) do base end
  def fold_left([head|tail],base,f) do
    fold_left(tail,f.(head,base),f)
  end
  def fold_left([],_) do 0 end
  def fold_left([head|tail], f) do
    fold_left(tail,f.(head),f)
  end

  def odd([]) do [] end
  def odd([head|tail]) do
    if (rem(head,2) == 1) do
      [head|odd(tail)]
    else
      odd(tail)
    end
  end

  def filter([],_) do [] end
  def filter([head|tail], f) do
    case f.(head) do
      :true -> [head | filter(tail,f)]
      :false -> filter(tail,f)
    end
  end
end
