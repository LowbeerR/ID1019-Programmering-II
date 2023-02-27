defmodule Moves do

  def single(move,{main,one,two}) do
    case move do
      {_,0} -> {main,one,two}
      {:one, n} ->
        if(n > 0) do {_,remain,taken} = Train.main(main,n)
        {remain,one ++ taken, two}
        else
        {_,remain,taken} = Train.main(one,n)
        {main ++ taken,remain, two}
        end
      {:two, n} ->
        if(n > 0) do {_,remain,taken} = Train.main(main,n)
        {remain,one, two ++ taken}
        else
        {_,remain,taken} = Train.main(two,n)
        {main ++ taken, one, remain}
        end
    end
  end

  def sequence([],state) do [state] end
  def sequence([head|tail], state) do
    [state | sequence(tail,single(head,state))]
  end
end
