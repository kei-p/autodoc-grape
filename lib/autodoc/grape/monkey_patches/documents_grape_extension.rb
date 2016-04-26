module DocumentsGrapeExtension
  def append(context, example)
    document = Autodoc::Document.new(context.clone, example.clone)
    document.extend DocumentGrapeExtension if grape_request?(document.send(:request))
    @table[document.pathname] << document
  end

  def grape_request?(request)
    return false unless defined?(Grape)
    routing_args = request.env["grape.routing_args"] || request.env["rack.routing_args"]
    routing_args[:route_info].instance_of?(Grape::Route) rescue false
  end
end

Autodoc::Documents.send(:prepend, DocumentsGrapeExtension)
