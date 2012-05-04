module Website
  module WebServer
    def apache
      template "/etc/apache2/sites-available/#{new_resource.name}" do
        cookbook "website"
        source "apache.vhost.conf.erb"
        variables(
          :website_name => new_resource.name,
          :website => new_resource.webserver
        )
        mode "0644"
      end

      directory "#{new_resource.webserver[:path]}/log" do
        owner new_resource.owner
        group new_resource.owner
        mode "0750"
      end

      apache_site new_resource.name
    end
  end
end
