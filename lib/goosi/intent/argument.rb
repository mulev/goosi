module Goosi
  # Intent argument
  class Argument
    attr_reader :name, :raw_text, :type, :value

    # Load intent argument
    #
    # @param argument [Hash] intent argument
    def initialize(argument)
      @arg = argument

      @name = @arg[:name] unless @arg[:name].nil?
      @raw_text = @arg[:rawText] unless @arg[:rawText].nil?
      define_type_and_value
    end

    private

    # Define argument type and value
    def define_type_and_value
      if boolean?
        @type = :boolean
        @value = @arg[:boolValue]
      elsif string?
        @type = :string
        @value = @arg[:textValue]
      elsif datetime?
        @type = :datetime
        @value = @arg[:datetimeValue]
      elsif extension?
        @type = :extension
        @value = @arg[:extension]
      else
        @type = :unknown
      end
    end

    # Is it a boolean value?
    #
    # @return [Boolean]
    def boolean?
      !@arg[:boolValue].nil?
    end

    # Is it a string value?
    #
    # @return [Boolean]
    def string?
      !@arg[:textValue].nil?
    end

    # Is it a datetime value?
    #
    # @return [Boolean]
    def datetime?
      !@arg[:datetimeValue].nil?
    end

    # Is it a extension value?
    #
    # @return [Boolean]
    def extension?
      !@arg[:extension].nil?
    end
  end
end
