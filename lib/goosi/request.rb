module Goosi
  # Request from Google Assistant
  class Request
    class << self
      # Build new request from Google Assistant
      #
      # @param request [Object] request from Google Assistant API,
      #                         can be hash or JSON encoded string
      # @param version [String] Google Assistant API version
      def build(request, version = '2')
        request = Oj.generate(request) if hash?(request)
        request = Oj.load(request, symbol_keys: true)
        new(request, version)
      end

      private

      # Check if object is a Hash or not
      #
      # @param obj [Object] some object
      # @return [Boolean]
      def hash?(obj)
        obj.is_a? Hash
      end
    end

    attr_reader :user, :session, :intents, :api_version

    # Initialize new request
    #
    # @param request [Hash] json request from Google Assistant API
    # @param version [String] Google Assistant API version
    # @raise [ArgumentError] if given request is invalid
    def initialize(request, version)
      @req = request
      @api_version = version

      invalid_request_exception if invalid_request?

      @user = initialize_user
      @session = initialize_session
      @intents = initialize_intents
    end

    # Check if it is a request from Google Actions sandbox
    #
    # @return [Boolean]
    def test?
      @req[:isInSandbox]
    end

    # Read Google Assistant user params, user device params and user location.
    # Further access to device and location information
    # is possible thru user instance
    #
    # @return [Object] new User object
    def initialize_user
      user = User.new(@req[:user], @req[:surface])
      user.load_location_params(@req[:device]) unless @req[:device].nil?
      user
    end

    # Read session params
    #
    # @return [Object] new Session object
    def initialize_session
      Session.new(@req[:conversation])
    end

    # Read intents
    #
    # @return [Array] array of all user intents
    def initialize_intents
      intents = []
      @req[:inputs].each do |i|
        intents << Intent.new(i)
      end
      sort_intents(intents)
    end

    private

    # Check if it is a valid Google Assistant request or not
    #
    # @return [Boolean]
    def invalid_request?
      @req[:user].nil? || @req[:surface].nil? || @req[:conversation].nil? ||
        @req[:inputs].nil?
    end

    # Request structure isn't valid, raise exception
    def invalid_request_exception
      raise ArgumentError,
            'Invalid request structure, ' \
            'please, refer to the Google Actions manual: ' \
            'https://developers.google.com/actions/' \
            'reference/rest/Shared.Types/AppRequest'
    end

    # Sort all intents ascending by last input created_at attribute
    #
    # @param intents [Array] array of all user intents
    # @return [Array] sorted array of all user intents
    def sort_intents(intents)
      intents.sort_by! do |i|
        i.inputs.last.created_at
      end
    end
  end
end
