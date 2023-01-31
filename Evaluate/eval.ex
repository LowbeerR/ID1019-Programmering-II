defmodule Eval do

  @type literal() :: {:num, number()}| {:var, atom()} | {:q, number(),number()}

  @type expr() :: {:add, expr(), expr()}
  | {:sub, expr(), expr()}
  | {:mul, expr(), expr()}
  | {:div, expr(), expr()}
  | literal()


  def go(exp, map) do simpl(eval(exp,map)) end
  def getint({:num, k}) do k end

  def simpl({:num, a}) do pprint({:num, a}) end
  def simpl({:q, a, a}) do pprint({:num, 1}) end
  def simpl({:q, a, 1}) do pprint({:num, a}) end
  def simpl({:q, a, 1.0}) do pprint({:num, a}) end
  def simpl({:q, a, b}) do
    pprint({:q, a/gcd(a,b), b/gcd(a,b)})
  end

  def gcd(a,0) do a end
  def gcd(a,b) do gcd(b,trunc(rem(a,b))) end

  def eval({:num, k}, _) do {:num, k} end
  def eval({:var, a}, map) do {:num, map[a]} end
  def eval({:q, k, a}, _) do {:q, k, a} end
  def eval({:add, k, a}, map) do
    add(eval(k,map), eval(a,map), map)
  end
  def eval({:sub, k, a}, map) do
    sub(eval(k,map), eval(a,map), map)
  end
  def eval({:mul, k, a}, map) do
    mul(eval(k,map), eval(a,map), map)
  end
  def eval({:div, k, a}, map) do
    div(eval(k,map), eval(a,map), map)
  end

  def add({:q,t,n}, {:q,t2,n2}, _) do {:q, ((n * t2)+(n2 * t)),n * n2} end
  def add({:q,t,n}, a, map) do {:q, (n*getint(eval(a,map))+t),n} end
  def add(k, {:q,t,n}, map) do {:q, (n*getint(eval(k,map))+t),n} end
  def add(k, a, map) do {:num, getint(eval(k,map)) + getint(eval(a,map))} end

  def sub({:q,t,n}, {:q,t2,n2}, _) do {:q, (n2*t-n*t2),n*n2} end
  def sub({:q,t,n}, a, map) do {:q, (t-n*getint(eval(a,map))),n} end
  def sub(k, {:q,t,n}, map) do {:q, (n*getint(eval(k,map))-t),n} end
  def sub(k, a, map) do {:num, getint(eval(k,map)) - getint(eval(a,map))} end

  def mul({:q,t,n}, {:q,t2,n2}, _) do {:q, t*t2,n*n2} end
  def mul({:q,t,n}, a, map) do {:q, (t*getint(eval(a,map))),n} end
  def mul(k, {:q,t,n}, map) do {:q, (t*getint(eval(k,map))),n} end
  def mul(k, a, map) do {:num, getint(eval(k,map)) * getint(eval(a,map))} end

  def div({:q,t,n}, {:q,t2,n2}, _) do {:q, t*n2,n*t2} end
  def div({:q,t,n}, a, map) do {:q, t,(n*getint(eval(a,map)))} end
  def div(k, {:q,t,n}, map) do {:q, t,(n*getint(eval(k,map)))} end
  def div(k, a, map) do {:q, getint(eval(k,map)), getint(eval(a,map))} end


  def pprint({:num, n}) do "#{trunc(n)}" end
  def pprint({:q, a, 1.0}) do a end
  def pprint({:q, a, b}) do "#{trunc(a)}/#{trunc(b)}" end
end
