module App
  # Convenience methods for various Rails directories.  Eliminates possibility of typos in directory names
  #
  #   App::Dir.environments_dir  #=> #<Pathname:/absolute_path_to/<Rails.root>/config/environments>
  module Dir
    module_function
    
    # Returns absolute path to +config+ directory
    # @return [Pathname]
    def config_dir
      Rails.root.join('config')
    end
 
    # Returns absolute path to +environments+ directory
    # @return [Pathname]
    def environments_dir
      Rails.root.join('config', 'environments')
    end
    
    # Returns absolute path to +lib+ directory
    # @return [Pathname]
    def lib_dir
      Rails.root.join('lib')
    end
    
    # Returns absolute path to +log+ directory
    # @return [Pathname]
    def log_dir
      Rails.root.join('log')
    end

    public *(methods(false))
  end

end