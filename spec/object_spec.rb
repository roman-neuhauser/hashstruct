# (c) Roman Neuhauser
# MIT-Licensed

describe Object do

  def construct
    Object.new
  end

  context "default constructor" do

    it "succeeds" do
      construct
    end

    it "creates instances of Object" do
      construct.class == Object
    end

  end

  context "members and attributes" do

    it "does not respond to #[]" do
      o = construct
      expect { o[:foo] }.to raise_error NoMethodError
    end

    it "does not respond to #[]=" do
      o = construct
      expect { o[:foo] = 42 }.to raise_error NoMethodError
    end

    it "does not permit member creation (#foo=)" do
      o = construct
      expect { o.foo = 42 }.to raise_error NoMethodError
    end

  end

end
