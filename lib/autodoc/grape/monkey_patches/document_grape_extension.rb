module DocumentGrapeExtension
 private

  def grape_request?
    defined?(Grape) && request.env["rack.routing_args"][:route_info].instance_of?(Grape::Route) rescue false
  end
end

Autodoc::Document.send(:prepend, DocumentGrapeExtension)
