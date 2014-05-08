# Openshift quick start for BaseX
This Git repository helps you get up and running quickly with 
a BaseX `basexhttp` installation on OpenShift.
 
[BaseX](http://basex.org/) is a very light-weight, high-performance and scalable
 XML Database engine and XPath/XQuery 3.0 Processor, 
 including full support for the W3C Update and Full Text extensions.
Built as a lightweight Java server, BaseX also supports XSLT, Webdav and RestXQ.
  
## Installation

Create OpenShift application

	rhc app create -a $name -t diy-0.1

and enter the directory

	cd $name

Add this repository as new remote

	git remote add upstream -m master https://github.com/Quodatum/openshift-basex-quick-start.git
and pull locally

	git pull -s recursive -X theirs upstream master

finally, deploy to OpenShift

	git push origin master

Now, your application is available at

	http://$name-$namespace.rhcloud.com

## Configuration

* The version of `BaseX` installed is set in the `.openshift/actions_hooks/start` script.
* REST and Webdav are deactivated (Edit `basex/webapp/WEB-INF/web.xml` to change this)
* Saxon is installed to provide XSLT2. (Saxon-HE 9.5.1.5 from sourceforge.net/projects/saxon)
* The FunctX library http://www.xqueryfunctions.com/ is installed to the BaseX repository
* A test RESTXQ function is provided to overwrite the BaseX sample. (edit `basex/webapp/restxq.xqm`)   

# TODO 
* Improve security, currently uses admin account/password
* Implement as a cartridge 
