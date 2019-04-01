module RoutificApi
  class SimpleAttributable < Attributable
    def values
      %i(name)
    end

    def object_values
      []
    end

    def collections
      []
    end

    def as_json
      name
    end
  end
end
