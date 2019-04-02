module RoutificApi
  module FactoryHelper
    def id
      params.fetch("id")
    end

    def name
      params.fetch("name")
    end

    def date
      params.fetch("date")
    end

    def phone_number
      params.fetch("phone_number")
    end

    def email
      params.fetch("email")
    end

    def start_time
      params.fetch("start")
    end

    def end_time
      params.fetch("end")
    end


    def shift_start
      params.fetch("shift_start")
    end

    def shift_end
      params.fetch("shift_end")
    end

    def duration
      params.fetch("duration")
    end

    def speed
      params.fetch("speed")
    end

    def capacity
      params.fetch("capacity")
    end

    def types
      params.fetch("types")
    end

    def load
      params.fetch("load")
    end

    def priority
      params.fetch("priority")
    end

    def notes
      params.fetch("notes")
    end

    def custom_notes
      params.fetch("custom_notes")
    end

    def shift_break
      params.fetch("break")
    end

    def address
      params.fetch("address")
    end

    def coords
      params.fetch("coords")
    end

    def max_stop_lateness
      params.fetch("max_stop_lateness")
    end

    def max_driver_overtime
      params.fetch("max_driver_overtime")
    end

    def shortest_distance
      params.fetch("shortest_distance")
    end

    def traffic
      params.fetch("traffic")
    end

    def strict_start
      params.fetch("strict_start")
    end

    def auto_balance
      params.fetch("auto_balance")
    end

    def default_load
      params.fetch("default_load")
    end

    def default_duration
      params.fetch("default_duration")
    end

    def location
      location_factory(params.fetch("location"))
    end

    def start_location
      location_factory(params.fetch("start_location"))
    end

    def end_location
      location_factory(params.fetch("end_location"))
    end

    def location_factory(params)
      RoutificApi::ProjectLocationFactory.new(params).call
    end

    def settings
      RoutificApi::SettingFactory.new(params.fetch("settings")).call
    end

    def collection_factory(type)
      params.fetch("#{ type }s").map do |params|
        Object
          .const_get(class_name(type.capitalize))
          .new(params).call
      end
    end

    def class_name(name)
      "RoutificApi::#{ name }Factory"
    end
  end
end
