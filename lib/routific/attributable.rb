module RoutificApi
  class Attributable
    include RoutificApi::Jsonable

    ATTRS = %i(values collections)
    def initialize(params)
      ensure_attrs_set
      set_attrs(params)
    end

    private

    def attrs
      values + collections
    end

    def ensure_attrs_set
      ATTRS.each do |attr|
        raise MissingAttributeError unless self.respond_to?(attr)
      end
    end

    def set_attrs(params)
      attrs.each do |attr|
        set_attr(attr, params[attr.to_s])
      end
    end

    def set_attr(attr, value)
      ensure_collection_is_array(attr, value)
      define_setter(attr, value)
      define_reader(attr)
      set_variable(attr, value)
    end

    def ensure_collection_is_array(attr, value)
      if collections.include?(attr) && value.class != Array
        raise NotArrayError
      end
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
  end
end
