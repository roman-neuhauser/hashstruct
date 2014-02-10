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
      expect(o[:foo]).to equal 42
      expect(o[:bar]).to equal 69
    end

    it "creates members from constructor arguments" do
      o = construct foo: 42, bar: 69
      expect(o.foo).to equal 42
      expect(o.bar).to equal 69
    end

  end

  context "construction from an Array" do

    it "creates keys from constructor arguments" do
      o = construct [[:foo, 42], [:bar, 69]]
      expect(o[:foo]).to equal 42
      expect(o[:bar]).to equal 69
    end

    it "creates members from constructor arguments" do
      o = construct [[:foo, 42], [:bar, 69]]
      expect(o.foo).to equal 42
      expect(o.bar).to equal 69
    end

  end

  context "dynamic access" do

    it "permits #[] with nonexistent keys" do
      o = construct
      expect(o[:foo]).to equal nil
    end

    it "permits key insertion (#[]=)" do
      o = construct
      m = Object.new
      expect(o[:foo] = m).to equal m
      expect(o[:foo]    ).to equal m
    end

  end

  context "static access" do

    it "does not permit member creation (#foo=)" do
      o = construct
      expect{ o.foo = 42 }.to raise_error \
        NoMethodError, /foo=/
    end

    it "permits member access (#foo)" do
      m = Object.new
      o = construct foo: m
      expect(o.foo).to equal m
    end

    it "permits member clobbering (#foo=)" do
      o = construct foo: 42
      expect(o.foo = 69).to equal 69
      expect(o.foo     ).to equal 69
    end

  end

  context "iteration" do

    def iteration_test method
      o = construct foo: 42, bar: 69
      p = {}
      o.send method do |k, v|
        p[k] = v
      end
      expect(p.size).to equal 2
      expect(p.keys).to include :foo
      expect(p.keys).to include :bar
      expect(p[:foo]).to equal 42
      expect(p[:bar]).to equal 69
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
      expect(p.size).to equal 2
      expect(p.keys).to include :foo
      expect(p.keys).to include :bar
    end

    it "supports #each_value" do
      o = construct foo: 42, bar: 69
      p = []
      o.each_value do |v|
        p << v
      end
      expect(p.size).to equal 2
      expect(p).to include 42
      expect(p).to include 69
    end

  end

end
