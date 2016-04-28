module ConfigurationGrapeExtension
  attr_accessor :grape_path_arrange
end

Autodoc::Configuration.send(:prepend, ConfigurationGrapeExtension)
