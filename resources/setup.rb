actions :create, :migrate, :configure, :upgrade, :disable, :delete

attribute :system_user

attribute :server_name,     :kind_of => String
attribute :cms,             :kind_of => Symbol,  :default => :plain, :equal_to => [:plain, :wordpress, :textpattern]
attribute :owner,           :kind_of => String
attribute :apache,          :kind_of => Hash
attribute :mysql,           :kind_of => Hash
attribute :ftp,             :kind_of => Hash

#TEXTPATTERN
#attribute :path,                :kind_of => String
#attribute :db_name,             :kind_of => String
#attribute :db_user,             :kind_of => String
#attribute :db_pass,             :kind_of => String
#attribute :db_host,             :kind_of => String
#attribute :db_charset,          :kind_of => String
#attribute :db_table_prefix,     :kind_of => String
#attribute :db_client_flags,     :kind_of => Array
#attribute :txpath,              :kind_of => String
#attribute :static_assets_host,  :kind_of => String

attribute :remote_ssh_host,      :kind_of => String
attribute :remote_ssh_port,      :kind_of => Fixnum,  :default => 22
attribute :remote_ssh_username,  :kind_of => String
attribute :remote_ssh_password,  :kind_of => String

def initialize(*args)
  super
  @action = [:create, :configure]
end
