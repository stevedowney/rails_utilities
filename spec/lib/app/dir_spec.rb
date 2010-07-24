require "#{File.dirname(__FILE__)}/../../spec_helper.rb"

describe App::Dir do
  
  it "should return config_dir" do
      App::Dir.config_dir.should == Pathname.new("#{::Rails.root}/config")
  end
  
  it "should return environments_dir" do
    App::Dir.environments_dir.should == Pathname.new("#{::Rails.root}/config/environments")
  end

  it "should return lib_dir" do
    App::Dir.lib_dir.should == Pathname.new("#{::Rails.root}/lib")
  end
  
  it "should return log_dir" do
    App::Dir.log_dir.should == Pathname.new("#{::Rails.root}/log")
  end
  
end