require 'fileutils'

module CrudInspector
  module Files
    class Manager
      def initialize(options)
        @options = options
      end

      def perform
        prepare_repo
        writer = CrudInspector::Files::Writer.new(@options, repo)
        case @options[:type]
        when :rest
          writer.extend(CrudInspector::Files::MimeTypes::Json).write
        when :soap
          writer.extend(CrudInspector::Files::MimeTypes::Xml).write
        else
          'type not supported'
        end

      end

      private
        def repo
          @repo ||= File.join(Rails.root, "crud_tracking", "services", @options[:klass].to_s.snakecase.gsub("::", "/"))
        end

        def prepare_repo
          if Dir.exist?(repo)
            CrudInspector::Files::Cleaner.new(repo).try_clean
          else
            FileUtils.mkdir_p(repo)
          end
        end
    end
  end
end
