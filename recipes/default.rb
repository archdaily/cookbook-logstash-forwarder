#
# Cookbook Name:: logstash-forwarder
# Recipe:: default
#
# Copyright (C) 2014 The Amazing DevTeam - ArchDaily
# 
# All rights reserved - Do Not Redistribute
#

package "python-software-properties"
package "git-core"
execute "add-apt-repository ppa:duh/golang"
execute "apt-get update"
package "golang"

execute "rm -rf logstash-forwarder ; git clone git://github.com/elasticsearch/logstash-forwarder.git" do
  cwd "/opt"
  user "root"
end

execute "go build" do
  cwd "/opt/logstash-forwarder"
end

execute "chmod +x logstash-forwarder.init ; cp logstash-forwarder.init /etc/init.d/logstash-forwarder" do
  cwd "/opt/logstash-forwarder"
  user 'root'
end

execute "mkdir bin/ ; cp logstash-forwarder bin/" do
  cwd "/opt/logstash-forwarder"
  user 'root'
end

cookbook_file "logstash-config.json" do
  path "/etc/logstash-forwarder"
  action :create
end

cookbook_file "logstash-key.pub" do
  path "/etc/ssl/logstash.pub"
  action :create
end

execute "update-rc.d logstash-forwarder defaults ; service logstash-forwarder start" do
  user 'root'
end
