module App
  # Convenience methods for various Rails directories.  Eliminates possibility of typos in directory names
  #
  #   > App::Dir.environments_dir
  #   => #<Pathname:/absolute_path_to/<Rails.root>/config/environments>
  module Dir
    module_function
      
    def config_dir
      Rails.root.join('config')
    end
 
    def environments_dir
      Rails.root.join('config', 'environments')
    end
    
    def lib_dir
      Rails.root.join('lib')
    end
    
    def log_dir
      Rails.root.join('log')
    end

    public *(methods(false))
  end

end