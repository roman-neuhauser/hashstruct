# (c) Roman Neuhauser
# MIT-Licensed

require 'ostruct'

class HashStruct

  def initialize hash = nil
    @impl = OpenStruct.new hash
    @keys = Hash[ hash.to_a.map { |k, v| [k.to_sym, true] } ]
  end

  def [] key
    @impl.send key
  end

  def []= key, val
    @impl.send "#{key}=", val
    @keys[key] = true
  end

  def merge! other
    other.each_pair do |key, val|
      self[key] = val
    end
  end

  def merge other
    rv = self.clone
    rv.merge! other
    rv
  end

  def method_missing sym, *args, &block
    key = sym
    key = key[0..-2].to_sym if key[-1] == '='
    raise NoMethodError.new sym.to_s unless @keys.include? key
    @impl.send sym, *args, &block
  end

  def each
    @keys.each_key { |key| yield key, self[key] }
  end

  def each_pair
    @keys.each_key { |key| yield key, self[key] }
  end

  def each_key
    @keys.each_key { |key| yield key }
  end

  def each_value
    @keys.each_key { |key| yield self[key] }
  end

private

  def initialize_copy src
    super src
    @impl = OpenStruct.new xx: 1, yy: 2
  end

end
