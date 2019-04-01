module RoutificApi
  class Stop
    def values
      %i(name start end duration load priority phone_number email notes)
    end

    def object_values
      %i(location custom_notes)
    end

    def collections
      %i(types)
    end
  end
end
