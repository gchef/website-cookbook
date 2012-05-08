module Website
  module Apache
    def configure_apache_vhost
      template "/etc/apache2/sites-available/#{@@website.name}" do
        cookbook "website"
        source "apache.vhost.conf.erb"
        variables(
          :website => @@website
        )
        mode "0644"
      end

      directory "#{@@website.path}/log" do
        owner @@website.username
        group @@website.owner
        mode "0750"
      end

      apache_site @@website.name
    end

    def apache?
      new_resource.apache
    end
  end
end
