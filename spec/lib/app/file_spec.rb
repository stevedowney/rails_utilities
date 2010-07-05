require "#{File.dirname(__FILE__)}/../../spec_helper.rb"

describe App::File do

  describe "absolute_path" do
    
    it "with absolute path" do
      App::File.absolute_path("/foo").should == Pathname("/foo")
    end
    
    it "with path relative to Rails root" do
      App::File.absolute_path("foo/bar").should == Pathname(::Rails.root.join("foo", "bar"))
    end
    
  end
  
  
end