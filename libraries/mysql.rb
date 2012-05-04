module Website
  module MySQL
    def setup_mysql_database
      mysql_database (new_resource.mysql[:name] || new_resource.mysql[:username]) do
        new_username new_resource.mysql[:username]
        new_password new_resource.mysql[:password]
        new_username_host new_resource.mysql[:host]
        action [:create_db, :grant_privileges]
      end
    end

    def mysql?
      new_resource.mysql
    end
  end
end
