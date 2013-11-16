<cfprocessingdirective suppresswhitespace="yes" >
<cfsetting enablecfoutputonly="yes">
<!--- Object to XML example. --->
<!--- Anything To XML will use the object's defined propery names to create the XML nodes --->

<!--- create an object --->
<cfset Customer = createObject('component', 'customer').init("Bob","Jones") />
<!---<cfdump var="#Customer#" > <cfabort>--->

<!--- create a list of attributes (optional)--->
<cfset AttributeList = "customerid" />

<cfset AnythingToXML =	createObject('component', 'AnythingToXML.AnythingToXML').init() />
<cfset myXML = AnythingToXML.toXML(Customer,"CUSTOMER",AttributeList) />
<cfoutput>#myXML#</cfoutput>
</cfprocessingdirective>