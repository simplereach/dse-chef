# CHANGELOG for dse-chef

This file is used to list changes made in each version of the dse-chef cookbook.

## 0.1.1
* adding *opscenter-agent* user to *ohai*

## 0.1.0
* adding *concurrent_compactors* to configuration attributes `node[:datastax][:cassandra][:concurrent_compactors]`
* adding *datastax* data bag item example

## 0.0.99
* adding server search to opscenter-agent recipe (node[:datastax][:opscenter][:server_role] attribute)
* agent configuration will warn and exit when server cannot be found or too many are found

## 0.0.98
* opscenter-server recipe

## 0.1.0:
* Initial release of dse-chef
