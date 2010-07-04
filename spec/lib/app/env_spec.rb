require "#{File.dirname(__FILE__)}/../../spec_helper.rb"

describe App::Env do
  
  it 'environment' do
    App::Env.environment.should == 'test'
  end
  
  it "environments" do
    App::Env.environments.should == ['development', 'production', 'test']
  end
  
  it "CONSTANTS" do
    App::Env::DEVELOPMENT.should == 'development'
  end
  
  it "predicate methods" do
    App::Env.test?.should be_true
    App::Env.not_test?.should be_false
  end
  
end