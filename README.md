
#Instructions to develop on this cookbook

* Download and install Vagrant

http://downloads.vagrantup.com/

* Install the vagrant-aws, vagrant-omnibus, vagrant-berkshelf (or berks i forget) plugins

* Configure and setup a gemset that uses chef and berks, don't install the vagrant gem.

* Berks should point at our chef server, unless you want to go chef solo, which I'd recommend, read the docs, it's quite easy to setup.  You'll probably have to configure berks to ignore ssl certs vertification.

```
# when you're ready

cd $cookbook_root

foodcritic .

# to see if your cookbook is ok

vagrant up --provider=aws

#this will fail initially

#login to the remote machine

vagrant ssh

# edit sudoers to !requiretty (search for 'tty')

# then logout

vagrant provision

# watch magic happen

```

Be sure if using chef_client provisioner to disable notifications for that host in nagios

