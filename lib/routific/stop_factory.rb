module RoutificApi
  class StopFactory
    include FactoryHelper

    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      Stop.new(
        "name"         => name,
        "location"     => location,
        "start"        => start_time,
        "end"          => end_time,
        "duration"     => duration,
        "types"        => types,
        "load"         => load,
        "priority"     => priority,
        "phone_number" => phone_number,
        "email"        => email,
        "notes"        => notes,
        "custom_notes" => custom_notes
      )
    end
  end
end
