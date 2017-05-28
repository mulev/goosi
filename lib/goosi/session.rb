module Goosi
  # Google assistant interaction session
  class Session
    attr_reader :id, :type, :token

    # Load session parameters
    #
    # @param params [Hash] session parameters, orginally named "conversation"
    def initialize(params)
      @id = params[:conversationId] unless params[:conversationId].nil?
      @type = params[:type] unless params[:type].nil?
      @token = params[:conversationToken] unless params[:conversationToken].nil?

      valid_session?
    end

    # Is it a new session?
    #
    # @return [Boolean]
    def new?
      @type == 'NEW'
    end

    # Is it an ongoing session?
    #
    # @return [Boolean]
    def ongoing?
      @type == 'ACTIVE'
    end

    # Is it an unknown session?
    #
    # @return [Boolean]
    def unknown?
      @type == 'TYPE_UNSPECIFIED'
    end

    private

    # Check if session is valid
    def valid_session?
      if @id.nil? || @type.nil? || @token.nil?
        raise ArgumentError, 'All conversation parameters must be defined'
      end
    end
  end
end
