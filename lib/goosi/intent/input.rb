module Goosi
  # Raw input from user
  class Input
    attr_reader :created_at, :type, :query

    # Load input
    #
    # @param input [Hash] input parameters
    def initialize(input)
      @created_at = DateTime.parse(input[:createTime])
      @type = input[:inputType]
      @query = input[:query]
    end

    # Is it an unknown input type?
    #
    # @return [Boolean]
    def unknown?
      @type == 'UNSPECIFIED_INPUT_TYPE'
    end

    # Is it an unknown input type?
    #
    # @return [Boolean]
    def touch?
      @type == 'TOUCH'
    end

    # Is it an unknown input type?
    #
    # @return [Boolean]
    def voice?
      @type == 'VOICE'
    end

    # Is it an unknown input type?
    #
    # @return [Boolean]
    def keyboard?
      @type == 'KEYBOARD'
    end
  end
end
