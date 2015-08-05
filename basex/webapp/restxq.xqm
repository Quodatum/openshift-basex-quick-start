(:~
 : This module contains a sample RESTXQ function
 : @copyright Quodatum
 : @license Apache
 : @author Andy Bunce
 :)
module namespace page = 'https://github.com/Quodatum/openshift-basex-quick-start';
declare default function namespace 'https://github.com/Quodatum/openshift-basex-quick-start';
import module namespace env = 'quodatum.basex.env';

(:~
 : This function generates the welcome page.
 : @return HTML page
 :)
declare
  %rest:path("")
  %output:method("html")
  %output:version("5.0")
   function page:start()
  as element(html)
{
  <html >
   <head>
 	<meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content="BaseX Openshift quickstart"/>
    <meta name="author" content="andy bunce"/>
	<title>BaseX Openshift quickstart</title>
	<link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.css" rel="stylesheet" type="text/css" />  
	</head>
    <body>
    <div class="container">
      <div class="navbar navbar-inverse" role="navigation">
        <div class="container-fluid">
          <div class="navbar-header">
            <a href="https://github.com/Quodatum/openshift-basex-quick-start" target="basex"
        class="navbar-brand">OpenShift BaseX Quick start</a>
            <ul class="nav navbar-nav ">
             <li><a  href="http://basex.org/" target="basex">BaseX</a> 
             </li>
             </ul>   
            <p class="navbar-text">version: {env:basex-version()}</p>
             <p class="navbar-text">Uptime: {env:jvmUptime()}</p>
             
          </div>
         </div>
        </div>
        <p ></p>
		<div class="row">
	<div class="col-md-6">{
	 let $app:=("dba","benchx")
	 let $body:=$app!<a href="{.}">{.}</a>
	 return panel("Applications",$body)
	}</div>
	<div class="col-md-6">
        {
        let $props:=property-table(env:about())
 		return panel("Environment Java Properties",$props)
 		}</div>
		</div>
		</div>
    </body>
  </html>
};


 
declare function property-table($map){
<table class="table table-striped table-condensed ">
<thead><tr><th>Name</th><th>Value</th></tr></thead>
<tbody>
{for $key in map:keys($map) 
 order by $key
 return <tr><td>{$key}</td>
          <td>{map:get($map,$key)}</td>
        </tr>}
</tbody>
</table>
};

declare function panel($title,$body){
<div class="panel  panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">{$title}</h3>
  </div>
  <div class="panel-body">
    {$body}
  </div>
</div>
};