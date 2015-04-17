module Vagrant
  module Portinfo
    class Command < Vagrant.plugin('2', :command)
      def self.synopsis
        "prints information about ports forwarded of a running machine."
      end

      def execute
        # options = {}

        opts = OptionParser.new do |o|
          o.banner = "Usage: vagrant portinfo [name]"
          o.separator ''
        end

        # Parse the options
        argv = parse_options(opts)
        return if !argv

        with_target_vms(argv, reverse: true) { |m| print_portinfo(m) }
      end

      private
      def print_portinfo(machine)
        @env.ui.info("#{machine.name} (#{machine.index_uuid[0..6]}) #{machine.state.short_description}")
        @env.ui.info("-" * 80)

        unless machine.provider_name == :virtualbox
          @env.ui.info("<not implemented for provider #{machine.provider_name}>")
          return
        end

        machine.provider.driver.read_forwarded_ports(machine.id, true).each do |i|
          @env.ui.info("guest: #{i[3]}\thost: #{i[2]}")
        end
      end
    end
  end
end