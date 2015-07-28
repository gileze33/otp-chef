include_recipe 'install_otp'

Chef::Log.info("About to run otp_download_graph for london")

otp_download_graph 'london' do
  action :create_if_missing
end

Chef::Log.info("About to run otp_server for london")

otp_server 'london' do
  # uses all defaults
end