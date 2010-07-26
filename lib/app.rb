# The App namespace is used in lieu of global methods and constants.
#
# Various utility methods are defined here; sub-modules of App have their methods mixed-in (sort of)
# so that App::SubModule.foo is available at App:foo.
module App
  
  # See discussion at http://www.ruby-forum.com/topic/62553
  VALID_IP_REGEX = /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/
  
  module_function
  # Prints a message to screen for long-running tasks.  Yields to block.  Does _no_ printing
  # in +test+ environment.
  #
  # @param [String] message the (starting) message to print to STDOUT
  # @param [Block] &block code containing the long-running process
  # 
  # @example Show the start/stop of a long-running process:
  #   log_to_screen("Starting long process") do
  #     long_proces()
  #   end
  #
  #   # Initially displays:                "Starting long process ..."
  #   # and when block finishes executing: "Starting long process ... done"
  #
  # @example Show progress:
  #   log_to_screen("Starting long process") do
  #     10.times do
  #       sleep 1
  #       print "."
  #     end
  #   end
  #
  #   # Initially displays:             "Starting long process ..."
  #   # prints a "." each iteration,
  #   # when block finishes executing:  "Starting long process ... ..........done"
  #
  #   # (You may need to call #sync or #flush on STDOUT if your OS is buffering output.)
  def log_to_screen(message, &block)
    if test?
      yield
    else
      print "#{message} ... "
      STDOUT.flush
      yield
      puts 'done'
      STDOUT.flush
    end
  end
end

App.send(:extend, App::Dir)
App.send(:extend, App::Env)
App.send(:extend, App::OS)
