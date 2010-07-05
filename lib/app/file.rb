module App
  # Convenience methods for handling files in Rails.
  module File
    module_function
    
    # Returns a Pathname instance for file at _absolute_or_relative_to_rails_root_.
    # Returned Pathname's path is always absolute.
    #
    #   Rails.root                       # => #<Pathname:/var/rails_app>
    #    
    #   App::File.absolute_path("/foo")  # => #<Pathname:/foo>
    #   App::File.absolute_path("foo")   # => #<Pathname:/var/rails_app/foo>
    def absolute_path(absolute_or_relative_to_rails_root)
      expanded_path = ::File.expand_path(absolute_or_relative_to_rails_root, Rails.root)
      Pathname.new(expanded_path)
    end
 
    public *(methods(false))
  end

end