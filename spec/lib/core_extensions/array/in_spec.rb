require "#{File.dirname(__FILE__)}/../../../spec_helper.rb"

describe Array, "in" do
  
  describe 'numeric' do
    
    it "single" do
      [1].in.should == %[(1)]
    end
    
    it "multiple" do
      [1, 2].in.should == %[(1, 2)]
    end

    it "empty" do
      [].in(:numeric => true).should == %[(-1)]
    end
    
    it "empty w/default" do
      [].in(:numeric => true, :default => 100).should == %[(100)]
    end
  end
  
  describe "non-numeric" do
    
    it "single" do
      ['a'].in.should == %[('a')]
    end
  
    it "multiple" do
      ['a', 'b', 'c'].in.should == %[('a', 'b', 'c')]
    end

    it "empty" do
      [].in.should == %[('__default__')]
    end
    
    it "empty w/default" do
      [].in(:default => 'foo').should == %[('foo')]
    end
    
  end
  
end