module Vagrant
  module Port
    class  PortError < Vagrant::Errors::VagrantError
      def initialize(msg)
        @msg = msg
        super
      end

      def error_message
        @msg
      end
    end
  end
end