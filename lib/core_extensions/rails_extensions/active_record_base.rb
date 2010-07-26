module ActiveRecord
  
  class Base
    
    class << self
      
      # Override default humanized attribute names in error messages.
      #
      # Typically you will never call this directly; it is called in building validation error messages.
      #
      # @param [String, Symbol] attribute the attribute whose name is being humanized
      # @return [String] the humanized version of attribute
      #
      # @example Default Behaviour
      #
      #   validates_presence_of :email
      #
      #   errors[:email]  #=> "Email can't be blank"
      #
      # @example Specifying Human Names
      #
      #   # Constant in ActiveRecord class
      #   HUMANIZED_ATTRIBUTES = {
      #     :email => "E-Mail Address"
      #   }
      #
      #   errors[:email]  #=> "E-mail Address can't be blank"
      def human_attribute_name(attribute)
        (const_defined?(:HUMANIZED_ATTRIBUTES) && const_get(:HUMANIZED_ATTRIBUTES)[attribute.to_sym]) || super
      end

      # Validates that _attribute_ is a valid ip address per {App::VALID_IP_REGEX}.
      #
      # @param [String, Symbol] attribute the attribute being validated
      # @param [Hash] options same as options for +validates_format_of+ with a few additional defaults
      # @option options [String] :message ("is not a valid ip address") error message
      # @option options [Regexp] :with (App::VALID_IP_REGEX) Regexp to match
      # @return [void]
      def validates_ip_address(attribute, options = {})
        options.merge!(:message => "is not a valid ip address")
        options.reverse_merge!(:with => App::VALID_IP_REGEX)
        validates_format_of attribute, options
      end

      # Validates that _attribute_ is a valid port number.  Enforces postive integer and within range.
      #
      # @param [String, Symbol] attribute the attribute being validated
      # @param [Hash] options same as options for +validates_numericality_of+ and +validates_numericality_of+
      #   with a few additional defaults and overrides
      # @option options [Range] :in (1024..65535) Range in which port must fall.
      # @option options [String] :message ("<click 'View source' to see>") this option is overridden
      # @return [void]
      def validates_port(attribute, options = {})
        vno_options = options.merge(:only_integer => true, :greater_than => 0, :message => "must be a positive integer")
        validates_numericality_of attribute, vno_options

        vio_options = options.reverse_merge(:in => 1024..65535)
        vio_options[:message] = "must be between #{vio_options[:in].to_s.sub("..", '-')}"
        validates_inclusion_of attribute, vio_options
      end

    end
  end
  
end