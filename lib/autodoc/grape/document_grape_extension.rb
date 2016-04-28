module DocumentGrapeExtension
  private

  def has_validators?
    !!validators
  end

  def method
    grape_options[:method]
  end

  def path
    path_pattern = if Grape::VERSION.to_f >= 0.16
      grape_pattern.path
    else
      grape_options[:path]
    end
    path_pattern.gsub(/\(.*\)$/,'')
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
