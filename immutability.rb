#!/usr/bin/env ruby
# encoding: UTF-8

# DSL to build a block of CSS code

class CSSBlock
  attr_reader :selector, :properties

  def initialize(selector, properties={})
    # ensure values can't be modified by duplicating and freezing
    @selector = selector.dup.freeze
    @properties = properties.dup.freeze
  end

  # used to add properties to a block
  def set(key, value=nil)
    new_properties = if key.is_a? Hash
                       key
                     elsif !value.nil?
                       {
                         key: value
                       }
                     else
                       raise "Either provide a Hash of values, or a key and value."
                     end

    # Return a new instance of CSSBlock and not add, edit or modify any state.
    self.class.new(self.selector, self.properties.merge(new_properties))
  end

  # Serialize the class contents
  def to_s
    serialised_properties = self.properties.inject([]) do |acc, (k, v)|
      acc + ["#{k}: #{v}"]
    end

    "#{self.selector} { #{serialised_properties.join('; ')} }"
  end
end

block = CSSBlock.new("#some_id .class a").
  set("color", "#FFF").
  set({"color": "#000", "text-decoration": "underline"})

puts block
