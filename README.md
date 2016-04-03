# Openshift quick start for BaseX
This Git repository helps you get up and running quickly with 
a BaseX `basexhttp` installation on OpenShift.
 
[BaseX](http://basex.org/) is a very light-weight, high-performance and scalable
 XML Database engine and XPath/XQuery 3.1 Processor, 
 including full support for the W3C Update and Full Text extensions.
Built as a lightweight Java server, BaseX also supports XSLT, Webdav and RestXQ.

[OpenShift](https://www.openshift.com/) is a cloud Platform-as-a-Service (PaaS) developed by Red Hat.

## Overview
Applications are pushed to Openshift using git. Openshift applications have a data area ${OPENSHIFT_DATA_DIR}
that persists across restarts and git pushes. 
This quick start works by manipulating the contents of that data area. 
A BaseX installation is created or updated at `${OPENSHIFT_DATA_DIR}/basex/` by the Openshift start script.
 
## Installation

Create OpenShift application where $name is the name for the new application

	rhc app create -a $name -t diy-0.1

and enter the directory

	cd $name

Add this repository as new remote

	git remote add upstream -m master https://github.com/Quodatum/openshift-basex-quick-start.git
and pull locally

	git pull -s recursive -X theirs upstream master

finally, deploy to OpenShift

	git push origin master

Now, the application is available at

	http://$name-$namespace.rhcloud.com

Make your application changes

    git add -A
    git commit -m "My bits"
    git push origin master
    	
The hosted application will be stopped and restarted with the updates.

## Configuration

* Configuration is set in the `config`. 
The version of BaseX to install is also set here, currently 8.4.1 
* REST and Webdav and RESTXQ are activated (Edit `basex/webapp/WEB-INF/web.xml` to change this)
* Saxon is installed to provide XSLT2. (Saxon-HE 9.7.0.1 from sourceforge.net/projects/saxon)
* The FunctX library http://www.xqueryfunctions.com/ is installed to the BaseX repository
* A test RESTXQ function is provided to overwrite the BaseX sample. (edit `basex/webapp/restxq.xqm`)   

The default port settings are set `config`:
* p 15005 database server
* s 15007 stop

## Users and permissions

Users and permissions are defined in the `users.xml` file in `first-data/`.
The supplied `users.xml` contains the required "admin" user and some sample users. 
The password for admin is set as "changeme". 
The sample users (case-sensitive) are: 

* Angie (admin privileges)
* Chris (create privileges)
* Will (write privileges)
* Ralph (read privileges)
* Nadine (no privileges)

The password for these users is the same as the user name.
I have borrowed these names from Michael Sperberg-McQueen, who asked the all the right questions 
in a review of an earlier version, 
[Running the BaseX XQuery engine in the OpenShift cloud platform](http://cmsmcq.com/mib/?p=1395)

**Edit the users.xml file according to your own requirements before git push. Perhaps by copying `user`entries from a local BaseX installation.**

No default user is set for REST and WebDAV (in `web.xml`) so authentication is required for all requests.
RESTXQ always uses the user "admin". 

## Initial data
When the server is started if no `users.xml` file is found in `${OPENSHIFT_DATA_DIR}/basex/data/`
then contents of `first-data` are copied to the `basex/data/` folder. This will normally happen only for 
the first run.

The `first-data/` folder may be populated with sub-folders containing BaseX databases.  
Valid content for the `first-data` is anything that may be in the BaseX data folder. This includes
database backups created from BaseX by the backup command. These may be restored via the dba application.

## Tips
To force updates to users and databases delete the active `${OPENSHIFT_DATA_DIR}/basex/data/users.xml`

To force the whole process to begin from the start without creating a new container delete
 `${OPENSHIFT_DATA_DIR}/basex`
 
## Bugs
Use https://github.com/Quodatum/openshift-basex-quick-start/issues

## Extras

* To have graphviz available use  https://github.com/puzzle/openshift-graphviz-cartridge

# Licence
* This software is licenced under the Apache 2 licence
* Saxon-HE is licenced under Mozilla Public License version 2.0 http://www.saxonica.com/license/license.xml
* FunctX is licenced under GNU-LGPL license http://www.functx.com/


# Changelog
https://github.com/Quodatum/openshift-basex-quick-start/releases

# Todo

* Implement as a cartridge 
