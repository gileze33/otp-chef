dir = "/usr/local/otp"

def download_otp() 
  url = "http://dev.opentripplanner.org/jars/otp-0.18.0.jar"
  path = "#{dir}/otp.jar"

  remote_file path do
    owner    new_resource.user if new_resource.user
    source   url
    backup   false
  end
end

def install() 
  package "awscli"

  include_recipe "java"

  directory dir do
  end

  download_otp
end

action :create do
  install()
end