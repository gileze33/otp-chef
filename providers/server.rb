action :create do
  # set default variables, as overridden node attributes are not available in resource
  router       = new_resource.router       || node['otp']['server']['router']
  port         = new_resource.port         || node['otp']['server']['port']
  user         = new_resource.user         || node['otp']['server']['user']
  service_name = new_resource.service_name || node['otp']['server']['service_name']
  graphs_dir   = new_resource.graphs_dir   || node['otp']['server']['graphs_dir']

  daemon       = "/usr/local/otp/otp.jar"

  user user do
    home   home
    shell  '/bin/false'
    system true
  end


  # deploy upstart script
  template "/etc/init/#{service_name}.conf" do
    mode      00644
    source    'upstart.conf.erb'
    cookbook  'otp'
    variables description: 'OTP server daemon',
              daemon:      "#{daemon} --server --port #{port} --graphs #{graphs_dir} --router #{router}",
              user:        user
  end

  link "/etc/init.d/#{service_name}" do
    to '/lib/init/upstart-job'
  end

  service service_name do
    supports   restart: true, status: true
    #subscribes :restart, "template[#{config_file}]"

    action [ :enable, :start ]
  end
end


action :delete do
  # set default variables, as overridden node attributes are not available in resource
  service_name = new_resource.service_name || node['otp']['server']['service_name']

  service(service_name) { action :stop }

  file("/etc/init/#{service_name}.conf") { action :delete }
  file("/etc/init.d/#{service_name}") { action :delete }
end
