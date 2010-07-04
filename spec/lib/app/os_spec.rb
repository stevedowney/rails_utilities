require "#{File.dirname(__FILE__)}/../../spec_helper.rb"

describe App::OS do
  
  it "should return constants" do
    App::OS::WINDOWS.should == 'windows'
    App::OS::LINUX.should == 'linux'
    App::OS::OSX.should == 'osx'
  end

  describe 'os()' do

    it "should return os() for windows" do
      App::OS.stub!(:target_os).and_return('Mswin32')
      App::OS.os.should == App::OS::WINDOWS
    end

    it "should return os() for windows built with ming" do
      App::OS.stub!(:target_os).and_return('mingw32')
      App::OS.os.should == App::OS::WINDOWS
    end

    it "should return os() for linux" do
      App::OS.stub!(:target_os).and_return('xLinuxy')
      App::OS.os.should == App::OS::LINUX
    end

    it "should return os() for OS X" do
      App::OS.stub!(:target_os).and_return('dDarwin8.10.3')
      App::OS.os.should == App::OS::OSX
    end

    it "os() should raise error for unknown os" do
      App::OS.stub!(:target_os).and_return('foo')
      lambda {App::OS.os}.should raise_error(App::OS::UnknownOSError)
    end

  end
  
  describe 'platform predicate methods' do
    
    it "windows?()" do
      App::OS.stub!(:target_os).and_return('mingw32')
      App::OS.windows?.should be_true
      App::OS.linux?.should be_false
    end

    it "linux?" do
      App::OS.stub!(:target_os).and_return('xLinuxy')
      App::OS.linux?.should be_true
      App::OS.windows?.should be_false
    end

    it "osx?" do
      App::OS.stub!(:target_os).and_return('dDarwin8.10.3')
      App::OS.osx?.should be_true
      App::OS.mac?.should be_true
      App::OS.windows?.should be_false
    end
    
  end
end