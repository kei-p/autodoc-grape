module DocumentsGrapeExtension
  def append(context, example)
    document = Autodoc::Document.new(context.clone, example.clone)
    document.extend DocumentGrapeExtension if grape_request?(document.send(:request))
    @table[document.pathname] << document
  end

  def grape_request?(request)
    begin
      if Grape::VERSION.to_f >= 0.16
        request.env["grape.routing_args"][:route_info].instance_of?(Grape::Router::Route)
      else
        request.env["rack.routing_args"][:route_info].instance_of?(Grape::Route)
      end
    rescue
      false
    end
  end
end

Autodoc::Documents.send(:prepend, DocumentsGrapeExtension)
