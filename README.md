# Openshift quick start for BaseX
This Git repository helps you get up and running quickly with 
a BaseX `basexhttp` installation on OpenShift.
 
[BaseX](http://basex.org/) is a very light-weight, high-performance and scalable
 XML Database engine and XPath/XQuery 3.0 Processor, 
 including full support for the W3C Update and Full Text extensions.
Built as a lightweight Java server, BaseX also supports XSLT, Webdav and RestXQ.
  
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
    	
The hosted application will be stopped and restarted with the updates.

## Configuration

* Configuration is set in the `config`. 
The version of BaseX to install is also set here, currently 8.3.1 
* REST and Webdav are deactivated (Edit `basex/webapp/WEB-INF/web.xml` to change this)
* Saxon is installed to provide XSLT2. (Saxon-HE 9.7.0.1 from sourceforge.net/projects/saxon)
* The FunctX library http://www.xqueryfunctions.com/ is installed to the BaseX repository
* A test RESTXQ function is provided to overwrite the BaseX sample. (edit `basex/webapp/restxq.xqm`)   

The default port settings are set `config`:
* p 15005 database server
* s 15007 stop

## Extras

* To have graphviz available use  https://github.com/puzzle/openshift-graphviz-cartridge

# Licence
* This software is licenced under the Apache 2 licence
* Saxon-HE is licenced under Mozilla Public License version 2.0 http://www.saxonica.com/license/license.xml
* FunctX is licenced under GNU-LGPL license http://www.functx.com/


# Changelog
https://github.com/Quodatum/openshift-basex-quick-start/releases

# Todo
* Improve security, currently uses admin account/password
* Implement as a cartridge 
