actions        :create, :delete
default_action :create

attribute :router,       kind_of: String, name_attribute: true
attribute :service_name, kind_of: String, default: "otp"
attribute :graphs_dir,   kind_of: String, default: "/usr/local/otp/graphs"
attribute :port,         kind_of: Integer, default: 5000