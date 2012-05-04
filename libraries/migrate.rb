module Website
  module Migrate
    def ssh_key_authentication
      ssh_key "local" do
        action :create
      end

      ssh_key new_resource.migrate_from_hostname do
        port    new_resource.migrate_from_port
        action  :allow
      end

      ssh_key migrate_from_ip do
        port    new_resource.migrate_from_port
        action  :allow
      end

      ssh_key new_resource.migrate_from_hostname do
        port      new_resource.migrate_from_port
        username  new_resource.migrate_from_username
        password  new_resource.migrate_from_password
        action    :copy
      end
    end

#node[:system_users].each do |username, username_properties|
 #user_home = username_properties[:home] || "/home/#{username}"
 #websites = username_properties[:websites]

 #websites.each do |website, website_properties|
   #next if migrate_these_websites.any? && !migrate_these_websites.include?(website)
   #next if !ENV["FORCE"] && File.exists?("#{user_home}/#{website}/.migrated")

   #if website_properties.has_key? "mysql"
     #website_properties[:mysql].each do |db, db_properties|
       #execute "#{website} :: backing up MySQL #{db} db on #{node[:migrate][:hostname]} ..." do
         #command %{
           #ssh -p #{node[:migrate][:port]} -t #{node[:migrate][:username]}@#{node[:migrate][:hostname]} \
           #mysqldump #{db} | bzip2 > #{user_home}/#{website}/#{db}.sql.bz2
         #}
       #end
     #end
   #end

   #execute "#{website} :: rsync-ing from #{node[:migrate][:hostname]} ..." do
     #command %{
       #rsync --recursive --copy-links --verbose --progress --checksum -e 'ssh -p #{node[:migrate][:port]}' \
       ##{node[:migrate][:username]}@#{node[:migrate][:hostname]}:#{user_home}/#{website}/ #{user_home}/#{website}/
     #}
     #only_if %{
       #ssh -p #{node[:migrate][:port]} -t #{node[:migrate][:username]}@#{node[:migrate][:hostname]} \
       #test -d #{user_home}/#{website}/
     #}
   #end

   #execute "#{website} :: ensuring correct permissions ..." do
     #command %{
       #chmod -fR 755 #{user_home}/#{website}
       #chown -fR #{username}:#{username} #{user_home}/#{website}
     #}
   #end

   #if website_properties.has_key? "mysql"
     #Chef::Log.info "#{website} :: restoring MySQL db(s) ..."
     #website_properties[:mysql].each do |db_name, db_properties|
       #hosting_db db_name do
         #database db_name
         #password node[:mysql][:server_root_password]
         #new_username db_properties[:username]
         #new_password db_properties[:password]
         #action :initialize
       #end

       #hosting_db db_name do
         #database db_name
         #mysqldump "#{user_home}/#{website}/#{db_name}.sql.bz2"
         #action :import
       #end
     #end
   #end

   #if website_properties.has_key? "textpattern"
     #Chef::Log.info "#{website} :: setting up Textpattern ..."
     #textpattern_app website do
       #path "#{user_home}/#{website}/public"
       #action website_properties["textpattern"].to_sym
     #end
   #end

   #if website_properties.has_key? "wordpress"
     #Chef::Log.info "#{website} :: setting up Wordpress ..."
     #wordpress_app website do
       #path "#{user_home}/#{website}/public"
       #action website_properties["wordpress"].to_sym
     #end
   #end

   #directory "#{user_home}/#{website}" do
     #owner username
     #group username
     #mode 0755
     #recursive true
   #end

   #execute "#{website} :: MIGRATED!" do
     #command %{
       #touch #{user_home}/#{website}/.migrated
       #chown #{username}.#{username} #{user_home}/#{website}/.migrated
     #}
   #end
 #end
#end
  end
end
