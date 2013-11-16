<cfprocessingdirective suppresswhitespace="yes" >
<cfsetting enablecfoutputonly="yes">
<!--- Array to XML example. --->
<!--- arrays by themselves aren't too interesting... --->


<!--- create an array --->
<cfset myIDs = arraynew(1) />
<cfset arrayappend(myIDs,"1") />
<cfset arrayappend(myIDs,"2") />
<cfset arrayappend(myIDs,"3") />
<!---<cfdump var="#myIDs#" > <cfabort>--->

<cfset AnythingToXML =	createObject('component', 'AnythingToXML.AnythingToXML').init() />
<cfset myXML = AnythingToXML.toXML(myIDs,"ID") />
<cfoutput>#myXML#</cfoutput>
</cfprocessingdirective>