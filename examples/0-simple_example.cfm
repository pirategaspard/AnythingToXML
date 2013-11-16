<cfprocessingdirective suppresswhitespace="yes" >
<cfsetting enablecfoutputonly="yes">
<!--- SimpleValue to XML example. --->
<cfset MyValue = "Hello World" />
<!---<cfdump var="#MyValue#" > <cfabort>--->
<cfset AnythingToXML =	createObject('component', 'AnythingToXML.AnythingToXML').init() />
<cfset myXML = AnythingToXML.toXML(MyValue) />
<cfoutput>#myXML#</cfoutput>
</cfprocessingdirective>