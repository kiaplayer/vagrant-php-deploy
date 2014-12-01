# Deployment to production servers with vagrant-php

This repository is addon for [vagrant-php](https://github.com/kiaplayer/vagrant-php) environment 
and is used for deployment of your PHP-application to a production server. 

## Requirements

You should create your own deploy repository with files from this repository.
In this new repository you can store production configuration files:

* `nodes/` - folder for json-files with node attributes (your project configuration can require several servers);
* `files/` - folder for any external files used in Chef cookbooks.

You must name your json-files with server IP's or DNS names. 
Name of json-file will be used for "deploy.sh" execution.

## How to deploy

You must prepare [vagrant-php](https://github.com/kiaplayer/vagrant-php) environment first. 
You should execute "vagrant up" once to download cookbook's dependencies for Chef-Solo.

Then you must clone your deploy repository into ".chef/deploy" folder of your main project.
Folder ".chef/deploy" is added in ".chef/.gitignore" to avoid VCS changes in your main project. 

Now you can execute:

    $ cd .chef/deploy
    $ ./deploy.sh <administrator_user>@<server_ip_or_dns_name>

You can specify private key for administrator user (if needed):

    $ ./deploy.sh <administrator_user>@<server_ip_or_dns_name> -i "private_key_path"

"deploy.sh" does the following:

* Copies ".chef" folder to server in "/tmp/.chef";
* Executes "provision.sh" on server;
* Deletes "/tmp/.chef" folder.

"provision.sh" does the following:

* Installs Chef-Solo on server (if needed);
* Runs Chef-Solo with node attributes from specified json file.
