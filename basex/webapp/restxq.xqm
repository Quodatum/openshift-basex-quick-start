(:~
 : This module contains a sample RESTXQ function
 : @copyright Quodatum
 : @license Apache
 : @author Andy Bunce
 :)
module namespace page = 'https://github.com/Quodatum/openshift-basex-quick-start';
declare default function namespace 'https://github.com/Quodatum/openshift-basex-quick-start';

declare namespace sys="java.lang.System";
declare namespace Runtime="java.lang.Runtime";
declare variable $page:core:=(
            "java.version","java.vendor","java.vm.version",
            "os.name","os.version","os.arch");
            

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
            
            <a class="navbar-brand" href="http://basex.org/">BaseX</a>    
            <p class="navbar-text">version: {basex-version()}</p>
            
          </div>
         </div>
        </div>
        <p >Quick start for Openshift</p>
        {
        let $props:=property-table(about())
 		return panel("Environment Java Properties",$props)
 		}</div>
    </body>
  </html>
};

(:~ @return BaseX version string :)
declare function basex-version() as xs:string{
db:system()/generalinformation/version
};

(: 
 : memory status
 :http://javarevisited.blogspot.co.uk/2012/01/find-max-free-total-memory-in-java.html
:)
declare function memory()as map(*){
map{
    "memory.free":prof:human(Runtime:freeMemory(Runtime:getRuntime())),
    "memory.max":prof:human(Runtime:maxMemory(Runtime:getRuntime())),
    "memory.total":prof:human(Runtime:totalMemory(Runtime:getRuntime()))
    }
};

(:~ useful java properties :)
declare function about() as map(*){
 let $c:= map:merge($page:core!map:entry(.,sys:getProperty(.)))
 return map:new(($c,memory()))
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