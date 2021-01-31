module RoutificApi
  class DriverFactory
    include FactoryHelper

    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      Driver.new(
        "name"           => name,
        "start_location" => start_location,
        "end_location"   => end_location,
        "shift_start"    => shift_start,
        "shift_end"      => shift_end,
        "phone_number"   => phone_number,
        "speed"          => speed,
        "capacity"       => capacity,
        "types"          => types,
        "break"          => shift_break
      )
    end
  end
end
