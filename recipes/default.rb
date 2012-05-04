node[:websites].each do |website_name, website_properties|
  website_setup website_name do
    type          website_properties[:type]
    path          website_properties[:webserver][:path]
    owner         website_properties[:owner]
    webserver     website_properties[:webserver]
    mysql         website_properties[:mysql]
    ftp           website_properties[:ftp]
    action        website_properties[:actions]
  end
end
