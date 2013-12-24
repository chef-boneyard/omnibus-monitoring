define :component_runit_service, :log_directory => nil,
                                 :svlogd_size => nil,
                                 :svlogd_num => nil,
                                 :ha => nil,
                                 :control => nil,
                                 :finish => false,
                                 :action => :enable do
  component = params[:name]
  log_directory = params[:log_directory]

  template "#{log_directory}/config" do
    source "config.svlogd"
    mode "0644"
    owner "root"
    group "root"
    variables(
      :svlogd_size => params[:svlogd_size],
      :svlogd_num  => params[:svlogd_num]
    )
  end

  runit_service component do
    action :enable
    retries 20
    control params[:control] if params[:control]
    finish params[:finish]
    options(
      :log_directory => log_directory
    )
  end

  if params[:action] == :down
    log "stop runit_service[#{component}]" do
      notifies :down, "runit_service[#{component}]", :immediately
    end
  end
end
