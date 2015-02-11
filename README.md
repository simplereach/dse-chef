dse-chef
========
Installs and configures [Datastax](http://www.datastax.com/) Enterprise or Datastax community [Cassandra](http://cassandra.apache.org/).

Requirements
------------

### Chef
Chef version 0.10.10+ and Ohai 0.6.12+ are required.

### Platform
* Ubuntu 12.10
* Ubuntu 14.04

**Notes**: This cookbook has been tested on the listed platforms. It may work on other platforms with or without modification.

Attributes
----------

Recipes
-------
### default
Installs and configures dse-chef.

### install
Installs Java

Data Bags
---------
From the *keys* data bag, there should be an item called _datastax_ that includes the username and password to download Datastax Enterprise. The format of the data in this data bag should be:

```json
{
  "id": "datastax",
  "user": "myuser",
  "password": "mypassword"
}
```


Roles
-----
TODO

Definitions
-----------
None

Libraries
---------
None

Resources/Providers
-------------------
None

Usage
-----

### Setup
TODO

Authors
-------
- Author:: Russell Bradberry <rbradberry@simplereach.com>
- Author:: Eric Lubow <elubow@simplereach.com>

