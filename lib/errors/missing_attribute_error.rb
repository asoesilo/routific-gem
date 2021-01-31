class MissingAttributeError < StandardError
  def initialize(msg = "Attribute not set in subclass")
    super
  end
end
