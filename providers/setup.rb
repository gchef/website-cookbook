action :install do
  setup_website and ensure_favicon and only_allow_access_to_owner

  setup_mysql_database if mysql?
  setup_ftp_account if ftp?
end

action :upgrade do
  setup_website and ensure_favicon and only_allow_access_to_owner
end

action :configure do
  configure_website and only_allow_access_to_owner
  self.send(new_resource.webserver[:type])
end

action :remove do

end

action :migrate do
  ssh_key_authentication
end

def load_current_resource
  extend Website::Common
  extend Website::MySQL
  extend Website::FTP
  extend Website::WebServer
  extend Website::Migrate

  ensure_website_directory

  case new_resource.type
  when :wordpress
    extend Website::WordPress
  when :textpattern
    extend Website::Textpattern
  else
    extend Website::Plain
  end

  sync_source unless new_resource.migrate_from_hostname
end
