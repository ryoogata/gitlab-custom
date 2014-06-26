#
# Cookbook Name:: gitlab-custom
# Recipe:: default
#
# Copyright 2014, Ryo Ogata
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/home/git/gitlab/Gemfile" do
    source "Gemfile"
    owner "git"
    group "git"
    mode "0644"
end

directory "/home/git" do
  mode 0701
end

file "/home/git/gitlab/Gemfile.lock" do
  action :delete
end

script "bundle-install" do
  interpreter "bash"
  user "git"
  cwd "/home/git/gitlab"
  code <<-EOH
    bundle install --path vendor/bundle --no-deployment
  EOH
  environment 'rvm_bin_path' => '/usr/local/rvm/bin', 
    'rvm_bin_path' => '/usr/local/rvm/bin',
    'GEM_HOME' => '/usr/local/rvm/gems/ruby-2.0.0-p451@gitlab',
    'MY_RUBY_HOME' => '/usr/local/rvm/rubies/ruby-2.0.0-p451',
    'rvm_path' => '/usr/local/rvm',
    'rvm_gem_options' => '--no-rdoc --no-ri',
    'rvm_prefix' => '/usr/local',
    'GEM_PATH' => '/usr/local/rvm/gems/ruby-2.0.0-p451@gitlab:/usr/local/rvm/gems/ruby-2.0.0-p451@global',
    'PATH' => '/usr/local/rvm/gems/ruby-2.0.0-p451@gitlab/bin:/usr/local/rvm/gems/ruby-2.0.0-p451@global/bin:/usr/local/rvm/rubies/ruby-2.0.0-p451/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/rvm/bin:/root/bin'
  notifies :restart, "service[gitlab]"
end
