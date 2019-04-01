module RoutificApi
  class Jsonable
    def initialize(params)
      set_attrs(params)
    end

    def as_json
      attrs.inject({}) do |json_data, attr|
        set_json(json_data, attr)
        json_data
      end
    end

    private

    def set_attrs(params)
      attrs.each do |attr|
        set_attr(attr, params[attr.to_s])
      end
    end

    def set_attr(attr, value)
      define_setter(attr, value)
      define_reader(attr)
      set_variable(attr, value)
    end

    def define_setter(attr, value)
      self.class.send(:define_method, "#{ attr }=".to_sym) do |value|
        instance_variable_set("@" + attr.to_s, value)
      end
    end

    def define_reader(attr)
      self.class.send(:define_method, attr.to_sym) do
        instance_variable_get("@" + attr.to_s)
      end
    end

    def set_variable(attr, value)
      self.send("#{ attr }=".to_sym, value)
    end

    def set_json(data, attr)
      enums.include?(attr) ? set_enum_json(data, attr) : set_value_json(data, attr)
    end

    def set_value_json(data, attr)
      data[attr.to_s] = add_attr_if_exists(attr)
    end

    def set_enum_json(data, attr)
      data[attr.to_s] = self.send(attr)
        .map(&:as_json)
    end

    def add_attr_if_exists(attr)
      self.send(attr) if self.send(attr)
    end
  end
end
