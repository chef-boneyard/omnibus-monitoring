name             "opscode-monitoring"
maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures opscode-monitoring"
long_description "Installs/Configures opscode-monitoring"
version          "0.1.0"
recipe           "opscode-monitoring", "Configures the Monitoring services from Omnibus"

%w{ ubuntu debian redhat centos }.each do |os|
  supports os
end

depends "runit"


