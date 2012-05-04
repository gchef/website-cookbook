default[:websites]      = []
default[:website][:src] = "/usr/local/src"

# WORDPRESS
#
default[:website][:wordpress][:version]  = "3.3.2"
default[:website][:wordpress][:dir]      = "wordpress-#{website.wordpress.version}"
default[:website][:wordpress][:archive]  = "#{website.wordpress.dir}.tar.gz"
default[:website][:wordpress][:source]   = "http://wordpress.org/#{website.wordpress.archive}"
default[:website][:wordpress][:checksum] = "3da62214ef274066ed7912a6f062000e173e267297e34b7b011f029366cc1b2f"

# TEXTPATTERN
#
default[:website][:textpattern][:version]  = "4.4.1"
default[:website][:textpattern][:dir]      = "textpattern-#{website.textpattern.version}"
default[:website][:textpattern][:archive]  = "#{website.textpattern.dir}.tar.gz"
default[:website][:textpattern][:source]   = "http://textpattern.com/file_download/70/#{website.textpattern.archive}"
default[:website][:textpattern][:checksum] = "e884db6e551c155f022533b6653867b048088cd3cbcbfe546b404696dd960dc2"
