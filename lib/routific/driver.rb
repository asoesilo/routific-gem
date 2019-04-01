module RoutificApi
  class Driver < Attributable
    def values
      %i(name shift_start shift_end phone_number speed capacity)
    end

    def object_values
      %i(start_location end_location break)
    end

    def collections
      %i(types)
    end
  end
end
