module Goosi
  # Response to Google Assistant request
  class Response
    # Initialize new response
    #
    # @param request [Object] Goosi::Request valid instance
    def initialize(request)
      @req = request
      @resp = { expectUserResponse: false }
      @rich_response = { items: [] }
    end

    # Tell something to Google Assistant user.
    # That will be the final response
    #
    # @param speech [String] response speech
    # @param display_text [String] response text, will be displayed in user app
    # @param ssml [Boolean] is it and SSML response or not
    def tell(speech, display_text = nil, ssml = false)
      @rich_response[:items] << make_speech(speech, display_text, ssml)
    end

    # Ask user some questions and wait for user response.
    # Not implemented now
    #
    # @param speech [String] response speech
    # @param display_text [String] response text, will be displayed in user app
    # @param ssml [Boolean] is it and SSML response or not
    def ask(_speech, _display_text = nil, _ssml = false)
      raise NotImpementedError, 'Conversations are not implemented now'
    end

    # Build response to Google Assistant request
    def build
      if @resp[:expectUserResponse]
        raise NotImpementedError, 'Conversations are not implemented now'
      end

      @resp[:finalResponse] = { richResponse: @rich_response }
    end

    private

    # Set conversation token
    def set_token
      @resp[:conversationToken] = @req.session.token
    end

    # Mark response as not final and awaiting for user input
    def not_final
      @resp[:expectUserResponse] = true
    end

    # Make speech and displayed text response object
    #
    # @param speech [String] response speech
    # @param display_text [String] response text, will be displayed in user app
    # @param ssml [Boolean] is it and SSML response or not
    def make_speech(speech, display_text, ssml)
      type = ssml ? :ssml : :textToSpeech
      speech = fix_ssml(speech) if ssml
      item = { simpleResponse: {} }
      item[:simpleResponse][type] = speech
      return item if display_text.nil?
      item[:simpleResponse][:displayText] = display_text
      item
    end

    # Forced fix of SSML speech - manually check and fix open and close tags
    #
    # @param text [String] SSML response speech
    # @return [String] fixed SSML speech
    def fix_ssml(text)
      open_tag = text.strip[0..6]
      close_tag = text.strip[-8..1]
      text = open_tag == '<speak>' ? text : "<speak>#{text}"
      close_tag == '</speak>' ? text : "#{text}</speak>"
    end
  end
end
