class Array

  # Returns SQL IN clause from Array for help building SQL statements:
  #
  # @param [Hash] options
  # @option options [Boolean] :numeric (false) set to +true+ to force numeric type
  # @option options [String] :default ('__default__') value to use when called on empty Array of String
  # @option options [Numeric] :default (-1) value to use when called on empty Array of Numeric
  # @return [String] parenthesized, comma-separated list of values (quoted if they are not numeric)
  #
  # @example String Array
  #   ids = %w(a b c)
  #   "select * from foo where id in #{ids.in}"  #=>  "select * from foo where id in ('a','b','c')"
  #
  #   ["a", "b"].in              #=> "('a','b')"
  #   [].in                      #=> "('__default__')"
  #   [].in(:default => 'foo')   #=> "('foo')"
  #
  # @example Numeric Array
  #   ids = [1,2,3]
  #   "select * from foo where id in #{ids.in}"  #=>  "select * from foo where id in (1,2,3)"
  #
  #   [1, 2].in                                #=> "(1,2)"
  #   [].in(:numeric => true)                  #=> "(-1)"
  #   [].in(:numeric => true, :default => 100)  #=> "(100)"
  #
  #   # not all are numbers!
  #   [1, 2, 'c'].in      #=> "('1', '2', 'c')"
  def in(options = {})
    numeric = options[:numeric] || (present? && all? { |e| e.is_a?(Numeric) })
    if numeric
      default = options[:default] || -1
      empty? ? "(#{default})" : "(" + map { |e| e }.join(", ") + ")"
    else
      default = options[:default] || '__default__'
      empty? ? "('#{default}')" : "(" + map { |e| "'#{e.to_s}'" }.join(", ") + ")"
    end
  end

end