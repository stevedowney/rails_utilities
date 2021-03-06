module App
  # Convenience methods relating to the Rails environments.
  #
  # For each file in <tt>config/environment</tt>, constants and predicate methods are defined.
  #
  #   App::Env.environment  #=> "development"
  #   App::Env::DEVELOPMENT #=> "development"
  #   App::Env.development? #=> true
  #   App::Env.not_development? #=> false
  #
  # Instead of:
  #
  #   if Rails.env == 'development'
  #     # do stuff
  #   end
  #
  # or worse:
  #
  #   if Rails.env == 'develpomnet' # see the typo?
  #     # do stuff
  #   end
  #
  # you can do:
  #
  #   if Rails.env == App::Env::DEVELOPMENT
  #     # do stuff
  #   end
  #
  # or better still:
  #
  #   if App::Env.development?
  #     # do stuff
  #   end
  #
  #   if App::Env.not_development?
  #     # do stuff
  #   end
  module Env
    module_function

    # Set environments by discovering all the environment files
    @@environments = ::Dir["#{App::Dir.environments_dir}/*.rb"].map { |file| File.basename(file, ".rb") }

    @@environments.each do |env|
      # Define constant, e.g.: DEVELOPMENT
      const_set(env.upcase, env)
      
      # Define postive predicate method, e.g.: development?
      method_pos = "#{env}?"
      define_method method_pos do
        environment == env
      end
      module_function method_pos
      
      # Define negative predicate method, e.g.: not_development?
      method_neg = "not_#{env}?"
      define_method method_neg do
        environment != env
      end
      module_function method_neg
    end

    # Returns current environment.  (Same as <tt>Rails.env</tt>.)
    # @return [String]
    def environment
      Rails.env
    end
    
    # Returns Rails environments defined in <tt>config/environments</tt>
    # @example
    #   App::Env.environments  #=> ["development", "production", "test"]
    # @return [Array<String>]
    def environments
      @@environments
    end
    
    public *(methods(false))
  end
  
end
