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

        def options
          validator[1]
        end

        def body
          "#{indent}* #{key} #{options[:type]}"
        end

        def payload
          string = ""
          string << " (#{assets.join(', ')})" if assets.any?
          string << " - #{options[:desc]}" if options[:desc]
          string
        end

        def required
          "required" if options[:required]
        end

        def assets
          @assets ||= [required, only].compact
        end

        def only
          "only: `#{options[:values].inspect}`" if options[:values]
        end
      end
    end
  end
end
