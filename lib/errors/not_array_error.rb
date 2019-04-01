class NotArrayError < StandardError
  def initialize(msg = "Not an array")
    super
  end
end
