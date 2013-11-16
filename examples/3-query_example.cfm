<cfprocessingdirective suppresswhitespace="yes" >
<cfsetting enablecfoutputonly="yes">
<!--- Query to XML example. --->
<!--- Anything To XML will use the query's Column names to create the XML nodes --->


<!--- create a query --->
<cfset idList = arraynew(1) />
<cfset productList = arraynew(1) />
<cfset priceList = arraynew(1) />
<cfset arrayappend(idList,"1") />
<cfset arrayappend(idList,"2") />
<cfset arrayappend(idList,"3") />
<cfset arrayappend(productList,"GI Joe") />
<cfset arrayappend(productList,"Transformer")/>
<cfset arrayappend(productList,"My Little Pony") />
<cfset arrayappend(priceList,"$10.00")/>
<cfset arrayappend(priceList,"$16.00") />
<cfset arrayappend(priceList,"$12.00") />
<cfset thisQuery = queryNew('') />
<cfset queryaddcolumn(thisQuery,'id',idList) />
<cfset queryaddcolumn(thisQuery,'name',productList) />
<cfset queryaddcolumn(thisQuery,'price',priceList) />
<!---<cfdump var="#thisQuery#" > <cfabort>--->

<!--- create a list of attributes (optional)--->
<cfset AttributeList = "id" />

<cfset AnythingToXML =	createObject('component', 'AnythingToXML.AnythingToXML').init() />
<cfset myXML = AnythingToXML.toXML(thisQuery,"PRODUCT",AttributeList) />
<cfoutput>#myXML#</cfoutput>
</cfprocessingdirective>