# (c) Roman Neuhauser
# MIT-Licensed

class HashStruct

  def initialize hash = {}
    @impl = Hash[hash]
  end

  def [] key
    @impl[key]
  end

  def []= key, val
    @impl[key] = val
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
    realsym = :[]
    if key[-1] == '='
      key = key[0..-2].to_sym
      realsym = :[]=
    end
    unless @impl.has_key? key
      raise NoMethodError.new "undefined method `%s' for %s" % [
        sym.to_s,
        self
      ]
    end
    @impl.send realsym, *([key] + args), &block
  end

  def each
    @impl.each_key { |key| yield key, self[key] }
  end

  def each_pair
    @impl.each_key { |key| yield key, self[key] }
  end

  def each_key
    @impl.each_key { |key| yield key }
  end

  def each_value
    @impl.each_key { |key| yield self[key] }
  end

private

  def initialize_copy src
    super src
    @impl = Hash[ xx: 1, yy: 2 ]
  end

end
