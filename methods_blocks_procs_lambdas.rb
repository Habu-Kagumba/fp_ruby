#!/usr/bin/env ruby
# encoding: UTF-8

# Method -> def some_method; end
# Are not 1st class - can't be passed around like a variable (a reference to a function).

# Blocks
# Example

def block_method
  yield if block_given?
end

block_method do
  'Called from a block'
end

# Blocks are infact Procs in disguise.
# Example

def block_proc(&block)
  block.class
end

block_proc do; end # => Proc

# Lambdas
#   Check no of args.
#   Closure tyoe return.

# ------------------------------------------------------------------------------------------
# High Order Functions
# ------------------------------------------------------------------------------------------

# Are functions that:
#   accept a fn as an argument
#   return a function as the return value

# Example
# High order function that takes blocks

words = ['foo', 'bar', 'baz', 'pibb']
words.map { |word| 'mr ' + word } # => ['mr foo', ...]

# Example
# High order function that returns a function

def adder(a, b)
  lambda { a + b }
end

adder_fn = adder(1, 2)
adder_fn.call # => 3

# Higher order fn applications.
# Partial application and currying

# Partial fn application: calling a function with some no of arguments, in order to get a function
# back that will take that many less arguments.
#
# Currying: taking a fn that takes n args and splitting it into n fns that take one arg.

# Example:
#   Given

proc { |x, y, z| x + y + z }

# partial application:
proc { |x, y| proc { |z| x + y + z } }

# currying:
proc { |x| proc { |y| proc { |z| x + y + z } } }

# Mega example
# Given a programme

def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def multiply(a, b)
  a * b
end

def divide(a, b)
  a / b
end

# 1st stab at refactoring
def apply_math(fn, a, b)
  a.send(fn, b)
end

apply_math(:+, 1, 2) # => 3

# 2nd stab -> Proc#curry
apply_operators = lambda do |fn, a, b|
  a.send(fn, b)
end

add = apply_operators.curry.(:+)
subtract = apply_operators.curry.(:-)
# [...]

add.(1, 2) # => 3
subtract.(2, 1) # => 1
