module God
  module Conditions
    class RestartFileTouched < PollCondition

      attr_accessor :restart_file

      def initialize
        super
      end

      def process_start_time
        Time.parse(`ps -o lstart  -p #{self.watch.pid} --no-heading`)
      end

      def restart_file_modification_time
        File.mtime(self.restart_file)
      end

      def valid?
        valid = true
        valid &= complain("Attribute 'restart_file' must be specified", self) if self.restart_file.nil?
        valid
      end

      def test
        process_start_time < restart_file_modification_time
      end

    end
  end
end
