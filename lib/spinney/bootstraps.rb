class OperatingSystemNotSupportedError < StandardError; end

module Spinney
  module Bootstraps
    class OperatingSystemNotImplementedError < StandardError; end

    def self.class_exists_for?(os_name)
      begin
        true if self.class_for_operating_system(os_name).class == Class
      rescue
        false
      end
    end

    def self.class_for_operating_system(os_name)
      begin
        os_class_name = os_name.gsub(/\s/, '')
        eval("Spinney::Boostraps::#{os_class_name}")
      rescue
        raise OperatingSystemNotImplementedError.new()
      end
    end
  end

  module Delegates
    def stream_command(cmd)
      prepare.stream_command(cmd)
    end

    def run_command(cmd)
      prepare.run_command(cmd)
    end

    def ui
      prepare.ui
    end

    def puppet_version
      prepare.puppet_version
    end

    def prepare
      @prepare
    end
  end

  module InstallCommands
    def bootstrap!
      run_pre_bootstrap_checks
      send("#{distro[:type]}_install")
    end

    def distro
      raise("#{self.class.name} needs to be implemented.")
    end

    def http_client_get_url(url, file)
      stream_command <<-BASH
        if command -v curl >/dev/null 2>&1; then
          curl -L -o #{file} #{url}
        else
          wget -O #{file} #{url}
        fi
      BASH
    end

    def install_rubygems
      ui.msg "Installing rubygems from source..."
      release = "rubygems-1.8.23"
      file = "#{release}.tgz"
      url = "http://production.cf.rubygems.org/rubygems/#{file}"
      http_client_get_url(url, file)
      run_command("tar -zxf #{file}")
      run_command("cd #{release} && sudo ruby setup.rb --no-format-executable")
      run_command("sudo rm -rf #{release} #{file}")
    end

    def apt_repo_install(codename)
      file = "puppetlabs-release-#{codename}.deb"
      url = "http://apt.puppetlabs.com/#{file}"
      http_client_get_url(url, file)
      run_command("dpkg -i #{file}")
      run_command("sudo apt-get update")
      run_command("sudo apt-get install -y puppet")
    end

    def yum_repo_install
      run_command("yum install -y http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm")
      run_command("yum install -y puppet")
    end
  end

  class Base
    include Spinney::Boostraps::Delegates
    include Spinney::Boostraps::InstallCommands

    def initialize(prepare)
      @prepare = prepare
    end

    def run_pre_bootstrap_checks; end
  end
end

Dir[File.dirname(__FILE__) + '/bootstraps/*.rb'].each { |b| require b }
