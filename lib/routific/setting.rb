module RoutificApi
  class Setting < Attributable
    def values
      %i(max_stop_lateness max_driver_overtime shortest_distance traffic strict_start auto_balance default_load default_duration)
    end

    def object_values
      []
    end

    def collections
      []
    end
  end
end
