actions :install, :upgrade, :configure, :remove, :migrate

attribute :name,       :kind_of => String,  :name_attribute => true
attribute :type,       :kind_of => Symbol,  :default => :plain
attribute :path,       :kind_of => String
attribute :owner,      :kind_of => String
attribute :webserver,  :kind_of => Hash
attribute :mysql,      :kind_of => Hash
attribute :ftp,        :kind_of => Hash

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

attribute :migrate_from_hostname,  :kind_of => String
attribute :migrate_from_port,      :kind_of => Fixnum,  :default => 22
attribute :migrate_from_username,  :kind_of => String
attribute :migrate_from_password,  :kind_of => String

def initialize(*args)
  super
  @action = [:install, :configure]
end
