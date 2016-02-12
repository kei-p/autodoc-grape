module DocumentGrapeExtension
 private

  def has_validators?
    !!(grape_request? && validators) || super
  end

  def route_info
    @route_info ||= begin
      grape_request? ? request.env["rack.routing_args"][:route_info] : nil
    end
  end

  def validators
    if grape_request?
      route_info.instance_variable_get(:@options)[:params]
    else
      super
    end
  end

  def parameters
    if grape_request?
      validators.map { |validator| Autodoc::Grape::Document::Parameter.new(validator) }.join("\n")
    else
      super
    end
  end

  def grape_request?
    defined?(Grape) && request.env["rack.routing_args"][:route_info].instance_of?(Grape::Route) rescue false
  end
end

Autodoc::Document.send(:prepend, DocumentGrapeExtension)
