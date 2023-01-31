defmodule Deriv do

@type literal() :: {:num, number()}| {:var, atom()}

@type expr() :: {:add, expr(), expr()}| {:mul, expr(), expr()}| {:exp, expr(), literal()}|{:ln, expr()}
|{:div, expr(), expr()}|{:sub, expr(), expr()}| {:sqrt, expr()}|{:sin, expr()}| {:cos, expr()}| literal()

def test() do
  e = {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 4}}
  d = deriv(e,:x)
  IO.write("expression: #{pprint(e)} \n")
  IO.write("derivation: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  :ok
end

def test2() do
  e = {:add, {:exp, {:var, :x}, {:num, 0.5}}, {:num, 4}}
  d = deriv(e,:x)
  IO.write("expression: #{pprint(e)} \n")
  IO.write("derivation: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  :ok
end

def test3() do
  e = {:div, {:exp, {:var, :x}, {:num, 3}}, {:var, :x}}
  d = deriv(e,:x)
  IO.write("expression: #{pprint(e)} \n")
  IO.write("derivation: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  :ok
end
def test4() do
  e = {:ln, {:exp, {:var, :x}, {:num, 4}}}
  d = deriv(e,:x)
  IO.write("expression: #{pprint(e)} \n")
  IO.write("derivation: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  :ok
end
def test5() do
  e = {:div, {:num, 1}, {:mul, {:var, :x}, {:num, 3}}}
  d = deriv(e,:x)
  IO.write("expression: #{pprint(e)} \n")
  IO.write("derivation: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  :ok
end
def test6() do
  e = {:sqrt, {:exp, {:var, :x}, {:num, 5}}}
  d = deriv(e,:x)
  IO.write("expression: #{pprint(e)} \n")
  IO.write("derivation: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  :ok
end
def test7() do
  e = {:sin, {:mul, {:var, :x}, {:num, 10}}}
  d = deriv(e,:x)
  IO.write("expression: #{pprint(e)} \n")
  IO.write("derivation: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  :ok
end
  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end
  def deriv({:mul, e1, e2}, v) do {:add, {:mul, deriv(e1,v),e2}, {:mul, e1, deriv(e2,v)}} end
  def deriv({:add, e1, e2}, v) do {:add, deriv(e1,v), deriv(e2,v)} end
  def deriv({:sub, e1, e2}, v) do {:sub, deriv(e1,v), deriv(e2,v)} end
  #x^n
  def deriv({:exp, e1, {:num, n}}, v)
  do {:mul, {:mul,{:num, n},{:exp, e1, {:num, n-1}}}, deriv(e1,v)}
  end
  #ln(x)
  def deriv({:ln, e1}, v) do {:div, deriv(e1, v), e1} end
  #1/x
  def deriv({:div, e1, e2}, v)
  do {:div, {:sub, {:mul, deriv(e1,v),e2}, {:mul, deriv(e2,v), e1}}, {:exp, e2,{:num, 2}}}
  end
  #sqrt
  def deriv({:sqrt, e1}, v)
  do {:div, deriv(e1,v), {:mul, {:num, 2}, {:sqrt, e1}}}
  end
  #sin
  def deriv({:sin, e1}, v) do {:mul, deriv(e1,v), {:cos, e1}} end

  def simplify({:add, e1, e2})
  do simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2})
  do simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2})
  do simplify_exp(simplify(e1), simplify(e2))
  end
  def simplify({:div, e1, e2})
  do simplify_div(simplify(e1), simplify(e2))
  end
  def simplify({:sub, e1, e2})
  do simplify_sub(simplify(e1), simplify(e2))
  end


  def simplify(e) do e end

  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add(e1,e2) do {:add, e1,e2} end


  def simplify_sub(e1, {:num, 0}) do e1 end
  def simplify_sub({:num, n1}, {:num, n2}) do {:num, n1-n2} end
  def simplify_sub(e1,e2) do {:sub, e1,e2} end

  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul(e1,e2) do {:mul, e1,e2} end

  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end

  def simplify_div(_, {:num, 0}) do "error" end
  def simplify_div(e1, {:num, 1}) do e1 end
  def simplify_div(e1, e1) do 1 end
  def simplify_div(e1, e2) do {:div, e1, e2} end


  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})"  end
  def pprint({:mul, e1, e2}) do "(#{pprint(e1)} * #{pprint(e2)})"  end
  def pprint({:exp, e1, {:num, n}}) do "(#{pprint(e1)})^#{n}" end
  def pprint({:div, e1, e2}) do "#{pprint(e1)}/#{pprint(e2)}" end
  def pprint({:sub, e1, e2}) do "(#{pprint(e1)} - #{pprint(e2)})"  end
  def pprint({:ln, e1}) do "ln(#{pprint(e1)})" end
  def pprint({:sqrt, e1}) do "sqrt(#{pprint(e1)})" end
  def pprint({:sin, e1}) do "sin(#{pprint(e1)})" end
  def pprint({:cos, e1}) do "cos(#{pprint(e1)})" end


end
