include_recipe 'aws'

graphs_dir = "/usr/local/otp/graphs"


def download(exec_action)
  router        = new_resource.router           || node['otp']['server']['router']
  graphs_dir    = new_resource.graphs_dir       || node['otp']['server']['graphs_dir']
  graphs_bucket = new_resource.graphs_bucket    || node['otp']['graphs_bucket']
  s3_file_name  = "latest-#{router}.tar.gz"
  dir           = "#{graphs_dir}/#{router}"

  directory graphs_dir
  directory dir

  aws_s3_file "#{graphs_dir}/#{s3_file_name}" do
    bucket graphs_bucket
    remote_path s3_file_name
  end

  tar_extract '#{graphs_dir}/#{s3_file_name}' do
    action :extract_local
    creates dir
  end
end

action :download do
  download(:download)
end

action :download_if_missing do
  download(:download_if_missing)
end
