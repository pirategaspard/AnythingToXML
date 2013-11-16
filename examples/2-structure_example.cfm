<cfprocessingdirective suppresswhitespace="yes" >
<cfsetting enablecfoutputonly="yes">
<!--- Query to XML example. --->
<!--- Anything To XML will use the structure's key names to create the XML nodes --->

<!--- create a structure --->
<cfset product = structnew() />
<cfset product.id = "1" />
<cfset product.name = "GI Joe" />
<cfset product.product = "$10.00" />

<!---<cfdump var="#product#" > <cfabort>--->

<!--- create a list of attributes (optional)--->
<cfset AttributeList = "id" />

<cfset AnythingToXML =	createObject('component', 'AnythingToXML.AnythingToXML').init() />
<cfset myXML = AnythingToXML.toXML(product,"PRODUCT",AttributeList) />
<cfoutput>#myXML#</cfoutput>
</cfprocessingdirective>