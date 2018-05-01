module CrudInspector::Files
  module MimeTypes
    module Xml
      require "rexml/document"

      def extension
        'xml'
      end

      def format(transaction)
        doc = REXML::Document.new(transaction.body)
        output = ""
        formatter = REXML::Formatters::Pretty.new
        formatter.write(doc, output)
        output
      end

      def content_body
        request? ? format(@options[:request]) : format(@options[:response])
      end
    end
  end
end
