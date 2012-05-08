node[:websites].each do |website_name, website_properties|
  system_user = bootstrap_system_user website_name do
    password          website_properties[:password]
    groups            website_properties[:groups]
    allows            website_properties[:allows]
    home_basepath     website_properties[:home_basepath]
    home_permission   website_properties[:home_permission]
    home_group        website_properties[:home_group]
    shell             website_properties[:shell]
    ssh_keys          website_properties[:keys]
    action            :create
  end

  website_setup website_name do
    user                  system_user
    server_name           website_properties[:server_name]
    cms                   website_properties[:cms]
    owner                 website_properties[:owner]
    apache                website_properties[:apache]
    mysql                 website_properties[:mysql]
    ftp                   website_properties[:ftp]
    action                website_properties[:actions]
    remote_ssh_host       website_properties[:remote_ssh_host]
    remote_ssh_port       website_properties[:remote_ssh_port]
    remote_ssh_username   website_properties[:remote_ssh_username]
    remote_ssh_password   website_properties[:remote_ssh_password]
  end
end
