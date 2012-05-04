module Website
  module FTP
    def setup_ftp_account
      vsftpd_user new_resource.ftp[:username] do
        password new_resource.ftp[:password]
        root new_resource.webserver[:path]
        action new_resource.ftp[:action]
      end
    end

    def ftp?
      new_resource.ftp
    end
  end
end
