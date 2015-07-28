package "awscli"

def download_otp(exec_action) 
  dir = "/usr/local/otp"
  url = "http://dev.opentripplanner.org/jars/otp-0.18.0.jar"
  path = "#{dir}/otp.jar"

  remote_file path do
    owner    new_resource.user if new_resource.user
    source   url
    action   exec_action
  end
end

def install(exec_action) 
  dir = "/usr/local/otp"

  include_recipe "java"

  directory dir do
  end

  download_otp do
    action exec_action
  end
end

action :create do
  install(:create)
end
action :create_if_missing do
  install(:create_if_missing)
end