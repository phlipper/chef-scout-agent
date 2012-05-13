#
# Cookbook Name:: scout-agent
# Recipe:: default
#
# Copyright 2012, Phil Cohen
#

# only proceed if the key has been set
if ! node["scout_agent"] || node["scout_agent"]["key"].empty?
  Chef::Log.info %(Add a ["scout_agent"]["key"] attribute to configure Scout Agent on this node.)
  return
end


require_recipe "rvm"


# local variables
scout_key       = node["scout_agent"]["key"]
scout_user      = node["scout_agent"]["user"]
scout_group     = node["scout_agent"]["group"]
scout_home      = "/home/#{scout_user}"
scout_ruby      = node["scout_agent"]["rvm_ruby"]
scout_gemset    = node["scout_agent"]["rvm_gemset"]
scout_rvm_env   = "#{scout_ruby}@#{scout_gemset}"
scout_version   = node["scout_agent"]["version"]
scout_node_name = node["scout_agent"]["node_name"]

scout_command  = "rvm #{scout_rvm_env} exec scout"
scout_command += %( --name="#{scout_node_name}") unless scout_node_name.empty?
scout_command += " #{scout_key}"


# create user and group
group scout_group do
  action [:create, :manage]
end

user scout_user do
  comment "Scout Agent"
  gid scout_group
  home scout_home
  supports :manage_home => true
  action [:create, :manage]
end


# ensure the rvm environment is setup
rvm_ruby scout_ruby
rvm_environment scout_rvm_env

rvm_gem "scout" do
  ruby_string scout_rvm_env
  version     scout_version
  action      :install
end

rvm_shell "scout_initial_run" do
  ruby_string scout_rvm_env
  cwd         scout_home
  code        scout_command
end

# schedule scout agent to run via cron
cron "scout_cron_run" do
  user scout_user
  command "/bin/bash -l -c 'source /etc/profile.d/rvm.sh && #{scout_command}'"
end

# install additional gems required for plugins
node["scout_agent"]["plugin_gems"].each do |plugin_gem|
  rvm_gem plugin_gem["name"] do
    ruby_string scout_rvm_env
    version     plugin_gem["version"] if plugin_gem["version"]
    action      [:install, :upgrade]
  end
end
