module RoutificApi
  module Jsonable
    def as_json
      attrs.inject({}) do |json_data, attr|
        set_json(json_data, attr)
        json_data
      end
    end

    private

    def set_json(data, attr)
      return set_json_collection(data, attr) if collections.include?(attr)
      return set_object_value(data, attr) if object_values.include?(attr)
      set_json_value(data, attr)
    end

    def set_json_value(data, attr)
      data[attr.to_s] = add_attr_if_exists(attr)
    end

    def set_json_collection(data, attr)
      data[attr.to_s] = self.send(attr)
        .map(&:as_json)
    end

    def set_object_value(data, attr)
      data[attr.to_s] = self.send(attr).as_json
    end

    def add_attr_if_exists(attr)
      self.send(attr) if self.send(attr)
    end
  end
end
