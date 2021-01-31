module RoutificApi
  class SettingFactory
    include FactoryHelper

    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      Setting.new(
        "max_stop_lateness"   => max_stop_lateness,
        "max_driver_overtime" => max_driver_overtime,
        "shortest_distance"   => shortest_distance,
        "traffic"             => traffic,
        "strict_start"        => strict_start,
        "auto_balance"        => auto_balance,
        "default_load"        => default_load, "default_duration"    => default_duration
      )
    end
  end
end
