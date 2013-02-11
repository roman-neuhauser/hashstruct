# (c) Roman Neuhauser
# MIT-Licensed

require 'hashstruct'

describe HashStruct do

  def construct *args
    HashStruct.new *args
  end

  context "default object constructor" do

    it "succeeds" do
      construct
    end

    it "creates instances of HashStruct" do
      construct.class == HashStruct
    end

  end

  context "construction from a Hash" do

    it "creates keys from constructor arguments" do
      o = construct foo: 42, bar: 69
      o[:foo].should equal 42
      o[:bar].should equal 69
    end

    it "creates members from constructor arguments" do
      o = construct foo: 42, bar: 69
      o.foo.should equal 42
      o.bar.should equal 69
    end

  end

  context "construction from an Array" do

    it "creates keys from constructor arguments" do
      o = construct [[:foo, 42], [:bar, 69]]
      o[:foo].should equal 42
      o[:bar].should equal 69
    end

    it "creates members from constructor arguments" do
      o = construct [[:foo, 42], [:bar, 69]]
      o.foo.should equal 42
      o.bar.should equal 69
    end

  end

  context "dynamic access" do

    it "permits #[] with nonexistent keys" do
      o = construct
      o[:foo].should equal nil
    end

    it "permits key insertion (#[]=)" do
      o = construct
      m = Object.new
      (o[:foo] = m).should equal m
    end

  end

  context "static access" do

    it "does not permit member creation (#foo=)" do
      o = construct
      expect { o.foo = 42 }.to raise_error NoMethodError, /foo=/
    end

    it "permits member access (#foo)" do
      m = Object.new
      o = construct foo: m
      (o.foo).should equal m
    end

    it "permits member clobbering (#foo=)" do
      o = construct foo: 42
      (o.foo = 69).should equal 69
    end

  end

  context "iteration" do

    def iteration_test method
      o = construct foo: 42, bar: 69
      p = {}
      o.send method do |k, v|
        p[k] = v
      end
      p.size.should equal 2
      p.keys.should include :foo
      p.keys.should include :bar
      p[:foo].should equal 42
      p[:bar].should equal 69
    end

    it "supports #each" do
      iteration_test :each
    end

    it "supports #each_pair" do
      iteration_test :each_pair
    end

    it "supports #each_key" do
      o = construct foo: 42, bar: 69
      p = {}
      o.each_key do |k, v|
        p[k] = true
      end
      p.size.should equal 2
      p.keys.should include :foo
      p.keys.should include :bar
    end

    it "supports #each_value" do
      o = construct foo: 42, bar: 69
      p = []
      o.each_value do |v|
        p << v
      end
      p.size.should equal 2
      p.should include 42
      p.should include 69
    end

  end

end
