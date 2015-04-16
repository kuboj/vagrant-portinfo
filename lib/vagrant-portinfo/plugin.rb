require "vagrant"

module Vagrant
  module Portinfo
    class Plugin < Vagrant.plugin("2")
      name "vagrant-portinfo"
      description "The `portinfo` command provides information about forwarded ports."

      command "portinfo" do
        require_relative "command"
        Command
      end
    end
  end
end