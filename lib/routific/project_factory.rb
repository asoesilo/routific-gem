module RoutificApi
  class ProjectFactory
    include FactoryHelper

    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      Project.new(
        "id"       => id,
        "name"     => name,
        "date"     => date,
        "drivers"  => collection_factory("driver"),
        "stops"    => collection_factory("stop"),
        "settings" => settings
      )
    end
  end
end
