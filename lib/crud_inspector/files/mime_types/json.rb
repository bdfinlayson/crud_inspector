module CrudInspector::Files
  module MimeTypes
    module Json
      PAYLOAD = %w(args payload).freeze

      def format(obj)
        JSON.pretty_generate obj
      rescue JSON::GeneratorError
        if payload(obj).class == String && payload(obj).length > 1000
          obj[PAYLOAD.first][PAYLOAD.second] = ''
        end
        JSON.pretty_generate obj
      end

      def extension
        'json'
      end

      def content_body
        request? ? format(request_body) : format(response_body)
      end

      def request_body
        @options[:request].as_json
      end

      def response_body
        JSON.parse(@options[:response].dup.body.as_json)
      rescue JSON::ParserError
        @options[:response].body
      end

      def payload(obj)
        obj.dig(*PAYLOAD)
      end
    end
  end
end
