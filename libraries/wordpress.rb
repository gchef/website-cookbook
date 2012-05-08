# http://codex.wordpress.org/Upgrading_WordPress_Extended
# http://wordpress.org/support/topic/nginx-php-fpm-php-apc-wordpress-multisite-subdirectory-wp-super-cache
#
module Website
  module WordPress
    def sync_source
      remote_file "#{node[:website][:src]}/#{node[:website][:wordpress][:archive]}" do
        source node[:website][:wordpress][:source]
        checksum node[:website][:wordpress][:checksum]
        action :create_if_missing
      end

      execute "Unarchiving #{node[:website][:wordpress][:archive]}" do
        cwd node[:website][:src]
        command %{
          tar zxf #{node[:website][:wordpress][:archive]}
          mv wordpress #{node[:website][:wordpress][:dir]}
        }
        creates "#{node[:website][:src]}/#{node[:website][:wordpress][:dir]}"
      end
    end

    def setup_website
      execute "Sync WP v#{node[:website][:wordpress][:version]} to #{@@website.path}" do
        command %{
          cd #{@@website.path}/public
          rsync --verbose --checksum --recursive #{node[:website][:src]}/#{node[:website][:wordpress][:dir]}/* .
          rm #{redundant_files}
        }
      end
    end

    def configure_website
      template "#{@@website.path}/public/wp-config.php" do
        cookbook "website"
        source "wordpress.config.php.erb"
        variables(
          :mysql => @@website.mysql
        )
        backup false
      end
    end

    def remove_website
      Chef::Log.info("~~~~~~~~~~~~~~~~~~~~~~ WIP")
    end

    def redundant_files
      %w[
        wp-config-sample.php
        license.txt
        readme.html
      ].join(" ")
    end
  end
end
