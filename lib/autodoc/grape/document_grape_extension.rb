module DocumentGrapeExtension
 private

  def has_validators?
    !!validators
  end

  def method
    grape_options[:method]
  end

  def path
    grape_options[:path].gsub(/\(.*\)$/,'')
  end

  def route_info
    @route_info ||= begin
      routing_args = request.env["grape.routing_args"] || request.env["rack.routing_args"]
      routing_args[:route_info]
    end
  end

  def grape_options
    route_info.instance_variable_get(:@options)
  end

  def validators
    route_info.instance_variable_get(:@options)[:params]
  end

  def parameters
    validators.map { |validator| Autodoc::Grape::Document::Parameter.new(validator) }.join("\n")
  end
end
