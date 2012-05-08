action :create do
  setup_website and ensure_favicon and only_allow_access_to_owner

  setup_mysql_database if mysql?
  setup_ftp_account if ftp?
end

action :migrate do
  authenticate_with_remote_host
end

action :configure do
  configure_website and only_allow_access_to_owner
  configure_apache_vhost if apache?
end

action :upgrade do
  setup_website and ensure_favicon and only_allow_access_to_owner
end

action :disable do

end

action :delete do

end

def load_current_resource
  extend SSH::Util

  extend Website::Common
  extend Website::FTP
  extend Website::MySQL
  extend Website::Apache

  ensure_website_directory

  case new_resource.cms
  when :wordpress
    extend Website::WordPress
  when :textpattern
    extend Website::Textpattern
  else
    extend Website::Plain
  end

  sync_source unless new_resource.remote_ssh_host
end
