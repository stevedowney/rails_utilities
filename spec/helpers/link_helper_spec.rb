require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe LinkHelper do
  
  before(:each) do
    @absolute_path = ::Rails.root.join("foo")
  end
  
  describe "file_link_label" do
    
    it "should default to file" do
      helper.file_link_label("foo").should == 'foo'
      helper.file_link_label("/foo").should == '/foo'
    end
    
    it "should take a label" do
      helper.file_link_label("foo", :label => 'bar').should == 'bar'
    end
    
    it "should return relative path" do
      helper.file_link_label(::Rails.root.join("foo"), :label => :relative_path).should == "foo"
    end
    
    it "should return absolute path" do
      helper.file_link_label("foo", :label => :absolute_path).should == ::Rails.root.join("foo").to_s
    end
    
    it "should return basename" do
      helper.file_link_label(::Rails.root.join("log/foo.log"), :label => :basename).should == "foo.log"
    end
    
  end
  
  describe "link_to_file" do
    
    it "absolute" do
      helper.link_to_file("/foo").should == %(<a href="file:///foo">/foo</a>)
    end
    
    it "relative" do
      helper.link_to_file("foo").should == %(<a href="file://#{@absolute_path}">foo</a>)
    end
    
    it "html options" do
      helper.link_to_file("foo", :class => 'klass').should == %(<a href="file://#{@absolute_path}" class="klass">foo</a>)
    end
    
  end
  
  describe "link_to_textmate_file" do
    
    it "absolute" do
      helper.link_to_textmate_file("/foo").should == %(<a href="txmt://open?url=file:///foo&line=&column=">/foo</a>)
    end
  
    it "relative" do
      helper.link_to_textmate_file("foo").should == %(<a href="txmt://open?url=file://#{@absolute_path}&line=&column=">foo</a>)
    end
    
    it "line and column" do
      expected = %(<a href="txmt://open?url=file://#{@absolute_path}&line=1&column=2">foo</a>)
      helper.link_to_textmate_file("foo", :line => 1, :column => 2).should == expected
    end

    it "html options" do
      expected = %(<a href="txmt://open?url=file://#{@absolute_path}&line=&column=" id="ID">foo</a>)
      helper.link_to_textmate_file("foo", :id => "ID").should == expected
    end
    
  end
  
end