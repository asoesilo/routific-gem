module RoutificApi
  class Job
    ATTRIBUTES = [:raw, :started_at, :finished_at, :id, :opts, :status, :visits, :fleet, :region, :route]

    attr_reader *ATTRIBUTES

    def initialize(attrs)
      attrs.each do |attr, value|
        next unless ATTRIBUTES.include?(attr.to_sym)
        if [:started_at, :finished_at].include?(attr.to_sym) && value
          value = Time.parse(value)
        end
        instance_variable_set "@#{attr}", value
      end
    end

    def self.parse(json)
      attrs = { raw: json }
      if route_json = json['output']
        attrs[:route] = Route.parse(route_json)
      end
      ATTRIBUTES.each do |attr|
        unless attrs.has_key?(attr)
          attrs[attr] = json[attr.to_s]
        end
      end
      new attrs
    end

    %w(pending finished).each do |s|
      define_method "#{s}?" do
        status == s
      end
    end
  end
end
