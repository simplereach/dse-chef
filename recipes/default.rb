#
# Cookbook Name:: dse-chef
# Recipe:: default
# Author:: Russ Bradberry <rbradberry@simplereach.com>
#

include_recipe 'dse-chef::install'
include_recipe 'dse-chef::configure'
