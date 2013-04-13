module Spiiney::Bootstraps
  class Linux < Base

    def issue
      prepare.run_command("cat /etc/issue").stdout.strip || prepare.run_command("lsb_release -d -s").stdout.strip
    end

    def x86?
      machine = run_command('uname -m').stdout.strip
      %w{i686 x86 x86_64}.include?(machine)
    end

    def package_list
      @packages.join(' ')
    end

    def gem_packages
      ['ruby-shadow']
    end

    def debianoid_gem_install
      ui.msg "Updating apt caches..."
      run_command("sudo apt-get update")

      ui.msg "Installing required packages..."
      @packages = %w(ruby ruby-dev libopenssl-ruby irb
                     build-essential wget ssl-cert rsync)
      run_command <<-BASH
        sudo DEBIAN_FRONTEND=noninteractive apt-get --yes install #{package_list}
      BASH

      gem_install
    end

    def yum_gem_install
      run_command("sudo yum clean all")
      run_command("sudo yum -y install rsync")
    end

    def distro
      return @distro if @distro
      @distro = case issue
      when %r{Debian GNU/Linux 6}
        {:type => "debianoid_gem"}
      when %r{Debian}
        {:type => "debianoid_gem"}
      when %r{Ubuntu}i
        {:type => "debianoid_gem"}
      when %r{CentOS}
        {:type => "yum_gem_install"}
      when %r{Amazon Linux}
        {:type => "yum_gem_install"}
      when %r{Red Hat Enterprise}
        {:type => "yum_gem_install"}
      when %r{Fedora}
        {:type => "yum_gem_install"}
      when %r{Scientific Linux}
        {:type => "yum_gem_install"}
      else
        raise "Distro not recognized from looking at /etc/issue."
      end
      @distro
    end
  end
end
