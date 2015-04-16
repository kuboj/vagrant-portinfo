module Vagrant
  module Port
    class Command < Vagrant.plugin('2', :command)
      def self.synopsis
        "prints information about ports forwarded of a running machine."
      end

      def execute
        # options = {}

        opts = OptionParser.new do |o|
          o.banner = "Usage: vagrant port [name]"
          o.separator ''
        end

        # Parse the options
        argv = parse_options(opts)
        return if !argv

        with_target_vms(argv, reverse: true) { |m| print_ports(m) }
      end

      private
      def print_ports(machine)
        @env.ui.info("#{machine.name} (#{machine.index_uuid[0..6]})")
        @env.ui.info("-" * 80)

        unless machine.provider_name == :virtualbox
          print_unknown
          return
        end

        out = Vagrant::Util::Subprocess.execute("vboxmanage", "showvminfo", machine.id)

        unless out.exit_code.zero?
          print_unknown
          return
        end

        parse_vminfo(out.stdout).each do |i|
          @env.ui.info("guest: #{i[:guest_port]}\thost: #{i[:host_port]}")
        end
      end

      def print_unknown
        @env.ui.info("<UNKNOWN>")
      end

      def parse_vminfo(s)
        out = []
        s.lines.select { |l| l =~ /guest port/ }.each do |l|
          out << {
              :host_port => l[/host\ port\ =\ \d*/, 0][/\d+/].to_i,
              :guest_port => l[/guest\ port\ =\ \d*/, 0][/\d+/].to_i
          }
        end

        out
      end
    end
  end
end