module App
  
  # Class for information about the operating system on which Rails is running.
  #
  #   if App::OS.windows?
  #     # do a windows thing
  #   else
  #     # do the non-windows version
  #   end
  #
  # A call to any method on an unkown platform will raise App::OS::UnknownOSError.
  #
  # All App::OS methods are available in the App namespace, i.e. App.windows? is the same thing as App::OS.windows?
  module OS
    
    # Raised when App::OS encounters an unknown OS (from <tt>Config::CONFIG['target_os']</tt>).
    class UnknownOSError < StandardError
    end
    
    WINDOWS = 'windows'
    LINUX = 'linux'
    OSX = 'osx'
    
    module_function

    # Returns +true+ for Windows platforms
    def windows?
      os == WINDOWS
    end
    
    # Returns +true+ for Linux platforms
    def linux?
      os == LINUX
    end
    
    # Returns +true+ for OSX (Mac) platforms.
    def osx?
      os == OSX
    end
  
    # Alias for osx?
    def mac?
      osx?
    end
    
    # Returns the operating system as one of the Constants.
    def os
      case target_os
      when /linux/i
        LINUX
      when /(win|w)32$/i
        WINDOWS
      when /darwin/i
        OSX
      else
        raise UnknownOSError, "CONFIG['target_os'] = '#{target_os}'"
      end
    end
    
    public *(methods(false))
    
    # Wrapper around Config to facilitate unit testing.
    def target_os #:nodoc:
      Config::CONFIG['target_os']
    end
  
  end
  
end