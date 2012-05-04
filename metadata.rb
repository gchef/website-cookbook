maintainer        "Gerhard Lazu"
maintainer_email  "gerhard@lazu.co.uk"
license           "Apache 2.0"
description       "Sets up websites with optional CMSes"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"

recipe            "website", "Configures a Plain, WordPress or Textpattern website. Apache, PHP & MySQL."
recipe            "website::migrate", "Migrates files via rsync, dumps & imports MySQL db"

supports "ubuntu" # 10.04 LTS specifically
supports "debian" # some tweaks might be required

depends "build-essential"

depends "apache2" # https://github.com/gosquared/apache2-cookbook
                  # "apache::modules" with %w[rewrite deflate headers proxy proxy_http auth_digest ssl]

depends "php"     # https://github.com/gchef/php-cookbook
                  # "php::extensions" with %w[apache gd mysql]

depends "mysql"   # https://github.com/gosquared/mysql-cookbook
