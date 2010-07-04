# The App namespace is used in lieu of global methods and constants.
#
# Various utility methods are defined here; sub-modules of App have their methods mixed-in (sort of)
# so that App::SubModule.foo is available at App:foo.
module App
  module_function
  # :call-seq: 
  #   log_to_screen(message, &block)
  #
  # Prints a message to screen for long-running tasks.  Yields to block and does _no_ printing
  # in +test+ environment.
  #
  #   log_to_screen("Starting long process") do
  #     long_proces()
  #   end
  #
  # Initially displays:
  #
  #   "Starting long process ..."
  #
  # and when block finishes executing:
  #
  #   "Starting long process ... done"
  #
  # Inside your long running process you may want to show some progress, i.e., <tt>print "."</tt>
  def log_to_screen(message)
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
