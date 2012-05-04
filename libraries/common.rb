module Website
  module Common
    def ensure_website_directory
      directory "#{new_resource.path}/public" do
        recursive true
      end

      directory "#{new_resource.path}/log" do
        recursive true
      end
    end

    def only_allow_access_to_owner
      execute "Owner is #{new_resource.owner}" do
        command %{
          chown -fR #{new_resource.owner}. #{new_resource.path}
          chmod u+s,g+s #{new_resource.path}
          chmod -fR 770 #{new_resource.path}
        }
      end
    end

    def ensure_favicon
      execute %{
        FAVICON=#{new_resource.path}/public/favicon.ico
        [ ! -e $FAVICON ] && touch $FAVICON
        exit 0
      }
    end
  end
end
