module RoutificApi
  class ProjectLocationFactory
    include FactoryHelper

    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      ProjectLocation.new(
        "address" => address,
        "coords"  => coords
      )
    end
  end
end
