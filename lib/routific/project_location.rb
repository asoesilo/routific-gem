module RoutificApi
  class ProjectLocation < Attributable
    def values
      %i(address)
    end

    def object_values
      %i(coords)
    end

    def collections
      []
    end
  end
end
