module RoutificApi
  class Project < Jsonable
    def values
      %i(id name date)
    end

    def enums
      %i(drivers stops settings)
    end

    def attrs
      values + enums
    end
  end
end
