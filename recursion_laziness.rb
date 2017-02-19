#!/usr/bin/env ruby
# encoding: UTF-8

# Concepts:
#   folding - #inject
#   functional recursion

# Recursion
# Example: factorials

def fact(n)
  return 1 if (0..1).include?(n)
  n * fact(n - 1)
end

# Enumerator: ruby generators

# example
# x = [1, 2, 3]

# enum = x.each
# puts enum.class
# puts enum.next
# puts enum.next
# puts enum.next
# puts enum.next

# 2nd stab at factorial using enumerable
def fact(n)
  (1..n).inject(:*) || 1
end

# Lazy enumerators
# Lazy evaluation is a feature used to force evaluation of values only as needed.

require 'mathn'

# Find first 20 prime numbers that contains the digit '3'
Prime.lazy.select { |x| x.to_s.include?('3') }.take(20).to_a

# Find the first 10 prime numbers where the sum of the digits is also prime.
Prime.lazy.select { |x| 1.to_s.chars.map(&:to_i).inject(:+) }.take(10).to_a
