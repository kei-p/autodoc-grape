module Autodoc
  module Grape
    module Document
      class Parameter
        attr_reader :validator

        def initialize(validator)
          @validator = validator
        end

        def to_s
          "#{body}#{payload}"
        end

        private

        def key
          validator[0]
        end

        def rule
          validator[1]
        end

        def body
          "* #{key} #{rule[:type]}"
        end

        def payload
          ""
        end
      end
    end
  end
end
