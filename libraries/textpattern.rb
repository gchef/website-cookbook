module Website
  module Textpattern
    def sync_source
      remote_file "#{node[:website][:src]}/#{node[:website][:textpattern][:archive]}" do
        source node[:website][:textpattern][:source]
        checksum node[:website][:textpattern][:checksum]
        action :create_if_missing
      end

      execute "Unarchiving #{node[:website][:textpattern][:archive]}" do
        cwd node[:website][:src]
        command %{
          tar zxf #{node[:website][:textpattern][:archive]}
        }
        creates "#{node[:website][:src]}/#{node[:website][:textpattern][:dir]}"
      end
    end

    def setup_website
      execute "Sync TXP v#{node[:website][:textpattern][:version]} to #{@@website.path}" do
        command %{
          cd #{@@website.path}/public
          rsync --verbose --checksum --recursive #{node[:website][:src]}/#{node[:website][:textpattern][:dir]}/* .
          rm #{redundant_files}
          chmod 777 #{@@website.path}/images #{@@website.path}/files
        }
        # It would be nice if we ran the install atuomatically
        # And have the admin user configured, then removed the setup
        # rm -fR #{new_resource.path}/textpattern/setup &&
      end
    end

    def configure_website
      template "#{@@website.path}/public/textpattern/config.php" do
        cookbook "website"
        source "textpattern.config.php.erb"
        variables(
          :mysql => new_resource.mysql
        )
        backup false
      end
    end

    def remove_website
      Chef::Log.info("~~~~~~~~~~~~~~~~~~~~~~ WIP")
    end

    def redundant_files
      %w[
        HISTORY.txt
        README.txt
        textpattern/checksums.txt
      ].join(" ")
    end
  end
end
