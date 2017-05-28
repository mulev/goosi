module Goosi
  # User device and its capabilities
  class Device
    # Read device capabilities
    def initialize(device)
      @capabilities = []

      return if device[:capabilities].nil?

      device[:capabilities].each do |c|
        @capabilities << c[:name]
      end
    end

    # Does that device supports audio output?
    #
    # @return [Boolean]
    def speakers?
      @capabilities.include? 'actions.capability.AUDIO_OUTPUT'
    end

    # Does that device have screen?
    #
    # @return [Boolean]
    def screen?
      @capabilities.include? 'actions.capability.SCREEN_OUTPUT'
    end
  end
end
