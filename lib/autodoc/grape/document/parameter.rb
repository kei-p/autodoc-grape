module Autodoc
  module Grape
    module Document
      class Parameter
        attr_reader :validator

        def initialize(validator)
          @validator = validator
        end

        def to_s
          ''
        end
      end
    end
  end
end
