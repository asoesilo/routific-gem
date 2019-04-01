module RoutificApi
  class Project < Attributable
    def values
      %i(id name date)
    end

    def object_values
      %i(settings)
    end

    def collections
      %i(drivers stops)
    end
  end
end
