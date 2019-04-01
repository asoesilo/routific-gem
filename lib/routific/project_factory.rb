module RoutificApi
  class ProjectFactory
    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      RoutificApi::Project.new(
        "id"      => params.fetch("id"),
        "name"    => params.fetch("name"),
        "date"    => params.fetch("date"),
        "drivers" => [],
        "stops"   => []
      )
    end
  end
end
