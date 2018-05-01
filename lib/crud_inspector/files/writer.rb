module CrudInspector
  module Files
    class Writer
      def initialize(options, repo)
        @options = options
        @repo = repo
      end

      def write
        retries ||= 0
        File.open(filepath, 'w') { |f| f.write(content) }
      end

      private
        def timestamp
          @timestamp ||= Time.now.strftime('%Y-%m-%d_%Hh_%Mm_%Ss')
        end

        def filepath
          @repo + '/' + timestamp + "_" + transaction_type.to_s + "." + extension
        end

        def transaction_type
          @options[:request].present? ? :request : :response
        end

        def request?
          transaction_type == :request
        end

        def request_url
          @options[:request].url
        end

        def response_code
          @options[:response].code
        end

        def request_url_content
          "REQUEST URL: #{request_url}"
        end

        def response_code_content
          "RESPONSE CODE: #{response_code}"
        end

        def content
          @content ||=
<<-CONTENT
CREATED AT: #{timestamp}
#{request? ? request_url_content : response_code_content}

#{transaction_type.to_s.upcase}:
#{content_body}

CONTENT
      end
    end
  end
end
