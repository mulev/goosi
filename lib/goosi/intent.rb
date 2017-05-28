module Goosi
  # User intent
  class Intent
    attr_reader :inputs, :name, :arguments

    # Load user intent
    #
    # @param intent [Hash] intent parameters from request
    def initialize(intent)
      @name = intent[:intent]
      load_inputs(intent[:rawInputs]) unless intent[:rawInputs].nil?
      load_arguments(intent[:arguments]) unless intent[:arguments].nil?
    end

    private

    # Load all user inputs
    #
    # @param opts [Hash] all user inputs
    def load_inputs(opts)
      @inputs = []
      opts.each do |i|
        @inputs << Input.new(i)
      end
      sort_inputs
    end

    # Sort all inputs ascending by created_at attribute
    def sort_inputs
      @inputs.sort_by!(&:created_at)
    end

    # Load all intent arguments
    #
    # @param opts [Hash] all intent arguments
    def load_arguments(opts)
      @arguments = []
      opts.each do |a|
        @arguments << Argument.new(a)
      end
    end
  end
end
