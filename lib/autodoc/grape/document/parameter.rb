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

        def indent
          " " * ( nest_key_names.count - 1 )
        end

        def nest_key_names
          validator[0].gsub(%r{\[(.*?)\]}, '__\1').split('__')
        end

        def key
          nest_key_names.last
        end

        def rule
          validator[1]
        end

        def body
          "#{indent}* #{key} #{rule[:type]}"
        end

        def payload
          ""
        end
      end
    end
  end
end
