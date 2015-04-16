require "vagrant"

module Vagrant
  module Port
    class Plugin < Vagrant.plugin("2")
      name "vagrant-port"
      description "The `port` command provides information about forwarded ports."

      command "port" do
        require_relative "command"
        Command
      end
    end
  end
end