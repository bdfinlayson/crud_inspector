require 'fileutils'

module CrudInspector
  module Files
    class Cleaner
      def initialize(repo)
        @repo = repo
      end

      def try_clean
        delete_oldest_file if file_count > 30
      end

      def delete_oldest_file
        FileUtils.rm full_path(files.first)
      end

      def files
        @files ||= begin
          entries = Dir.entries(@repo).drop_while { |file| ['.','..'].include?(file) }
          entries = entries.sort_by { |filename| File.ctime(full_path(filename)) }
          entries
        end
      end

      def file_count
        files.count
      end

      def full_path(filename)
        @repo.dup + '/' + filename
      end
    end
  end
end
