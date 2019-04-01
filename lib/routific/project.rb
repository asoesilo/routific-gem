module RoutificApi
  class Project < Attributable
    def values
      %i(id name date)
    end

    def collections
      %i(drivers stops settings)
    end

    def attrs
      values + enums
    end
  end
end
