module DocumentGrapeExtension
  def path_pattern
    if Grape::VERSION.to_f >= 0.16
      grape_pattern.path
    else
      grape_options[:path]
    end
  end

  private

  def method
    grape_options[:method]
  end

  def has_validators?
    !!validators
  end

  def path
    if Autodoc.configuration.grape_path_arrange
      Autodoc.configuration.grape_path_arrange.call(self)
    else
      path_pattern
    end
  end

  def validators
    route_info.instance_variable_get(:@options)[:params]
  end

  def parameters
    validators.map { |validator| Autodoc::Grape::Document::Parameter.new(validator) }.join("\n")
  end

  def route_info
    @route_info ||= begin
      if Grape::VERSION.to_f >= 0.16
        request.env["grape.routing_args"][:route_info]
      else
        request.env["rack.routing_args"][:route_info]
      end
    end
  end

  def grape_options
    route_info.instance_variable_get(:@options)
  end

  def grape_pattern
    route_info.instance_variable_get(:@pattern)
  end
end
