module Goosi
  # User, who interacts with Google Assistant
  class User
    attr_reader :id, :display_name, :first_name, :last_name, :device, :location
    attr_accessor :access_token

    # Describe Google device user
    #
    # @param user [Hash] user parameters
    # @param device [Hash] user device parameters
    def initialize(user, device)
      @id = user[:userId]
      @access_token = user[:accessToken] unless user[:accessToken].nil?
      @permissions = user[:permissions] unless user[:permissions].nil?
      @device = Device.new(device)
      load_profile(user[:profile]) if profile_accessible?
    end

    # Check if user granted us access to his profile info
    #
    # @return [Boolean]
    def precise_location_accessible?
      @permissions.include? 'DEVICE_PRECISE_LOCATION'
    end

    # Check if user granted us access to his profile info
    #
    # @return [Boolean]
    def coarse_location_accessible?
      @permissions.include? 'DEVICE_COARSE_LOCATION'
    end

    # Load user location parameters
    #
    # @param location [Hash] user location parameters
    def load_location_params(location)
      @location = Location.new(location)
      @location.load_precise_info if precise_location_accessible?
      @location.load_coarse_info if coarse_location_accessible?
    end

    private

    # Check if user granted us access to his profile info
    #
    # @return [Boolean]
    def profile_accessible?
      @permissions.include? 'NAME'
    end

    # Set profile parameters
    #
    # @param profile [Hash] user profile parameters
    def load_profile(profile)
      @display_name = profile[:displayName] unless profile[:displayName].nil?
      @first_name = profile[:givenName] unless profile[:givenName].nil?
      @last_name = profile[:familyName] unless profile[:familyName].nil?
    end
  end
end
