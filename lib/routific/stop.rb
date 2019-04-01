module RoutificApi
  class Stop
    def values
      %i(name location start end duration load priority phone_number email notes custom_notes)
    end

    def collections
      %i(types)
    end
  end
end
