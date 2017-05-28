module Goosi
  # User location parameters
  class Location
    attr_reader :name, :phone_number, :notes, :coordinates, :formatted_address,
                :zip_code, :city, :postal_address

    # Load user location parameters
    #
    # @param location [Hash] user location parameters
    def initialize(location)
      @location = location

      @name = @location[:name] unless @location[:name].nil?
      unless @location[:phoneNumber].nil?
        @phone_number = @location[:phoneNumber]
      end
      @notes = @location[:notes] unless @location[:notes].nil?
    end

    # Load precise location information
    def load_precise_info
      @coordinates = @location[:coordinates] unless @location[:coordinates].nil?
      return if @location[:formattedAddress].nil?
      @formatted_address = @location[:formattedAddress]
    end

    # Load coarse location information
    def load_coarse_info
      @zip_code = @location[:zipCode] unless @location[:zipCode].nil?
      @city = @location[:city] unless @location[:city].nil?
      return if @location[:postalAddress].nil?
      @postal_address = @location[:postalAddress]
    end
  end
end
