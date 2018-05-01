require 'fileutils'

require 'crud_inspector/files/cleaner'
require 'crud_inspector/files/manager'
require 'crud_inspector/files/writer'

require 'crud_inspector/files/mime_types/json'
require 'crud_inspector/files/mime_types/xml'

module CrudInspector
  class Tracker
    def initialize(options = {})
      @options = options
    end

    def track
      return unless ::Rails.env.development?
      case @options[:type]
      when :rest
        ::CrudInspector::Files::Manager.new(@options.merge!(type: :rest)).perform
      when :soap
        ::CrudInspector::Files::Manager.new(@options.merge!(type: :soap)).perform
      else
        "no type given"
      end
    end
  end
end
