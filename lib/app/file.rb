module App
  # Convenience methods for handling files in Rails.
  module File
    module_function
    
    # Takes absolute or relative path and returns absolute path.
    # Relative path is relative to +Rails.root+.
    #
    # @param [String, Pathname] absolute_or_relative_path
    # @return [Pathname] absolute path
    #
    # @example absolute path
    #   App::File.absolute_path("/foo")  # => #<Pathname:/foo>
    #
    # @example relative path
    #   Rails.root                       # => #<Pathname:/var/rails_app>
    #   App::File.absolute_path("foo")   # => #<Pathname:/var/rails_app/foo>
    def absolute_path(absolute_or_relative_path)
      expanded_path = ::File.expand_path(absolute_or_relative_path, Rails.root)
      Pathname.new(expanded_path)
    end
 
    public *(methods(false))
  end

end