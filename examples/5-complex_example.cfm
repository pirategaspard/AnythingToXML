<cfprocessingdirective suppresswhitespace="yes" >
<cfsetting enablecfoutputonly="yes">
<!--- Complex to XML example. --->
<!--- This is where the fun begins --->

<!--- create 1st query --->
<cfset idList = arraynew(1) />
<cfset productList = arraynew(1) />
<cfset priceList = arraynew(1) />
<cfset arrayappend(idList,"1") />
<cfset arrayappend(idList,"2") />
<cfset arrayappend(productList,"GI Joe") />
<cfset arrayappend(productList,"Transformer")/>
<cfset arrayappend(priceList,"$10.00")/>
<cfset arrayappend(priceList,"$16.00") />
<cfset thisQueryOne = queryNew('') />
<cfset queryaddcolumn(thisQueryOne,'id',idList) />
<cfset queryaddcolumn(thisQueryOne,'name',productList) />
<cfset queryaddcolumn(thisQueryOne,'price',priceList) />
<!---<cfdump var="#thisQueryOne#" > <cfabort>--->

<!--- create 2nd query --->
<cfset idList = arraynew(1) />
<cfset productList = arraynew(1) />
<cfset priceList = arraynew(1) />
<cfset arrayappend(idList,"3") />
<cfset arrayappend(productList,"My Little Pony") />
<cfset arrayappend(priceList,"$12.00") />
<cfset thisQueryTwo = queryNew('') />
<cfset queryaddcolumn(thisQueryTwo,'id',idList) />
<cfset queryaddcolumn(thisQueryTwo,'name',productList) />
<cfset queryaddcolumn(thisQueryTwo,'price',priceList) />
<!---<cfdump var="#thisQueryTwo#" > <cfabort>--->


<!--- create an array containing two structures which each hold a customer object and a query --->
<cfset TheseOrders = arrayNew(1) />

<cfset TheseOrders[1] = structnew() />
<cfset TheseOrders[1].OrderNumber = createUUID() />
<cfset TheseOrders[1].Customer = createObject('component', 'customer').init("Bob","Jones") />
<cfset TheseOrders[1].Product = thisQueryOne />

<cfset TheseOrders[2] = structnew() />
<cfset TheseOrders[2].OrderNumber = createUUID() />
<cfset TheseOrders[2].Customer = createObject('component', 'customer').init("Jill","Jones") />
<cfset TheseOrders[2].Product = thisQueryTwo />

<!--- create a list of attributes (optional)--->
<cfset AttributeList = "OrderNumber,customerid,id" />

<cfset AnythingToXML =	createObject('component', 'AnythingToXML.AnythingToXML').init() />
<cfset myXML = AnythingToXML.toXML(TheseOrders,"ORDER",AttributeList) />
<cfoutput>#myXML#</cfoutput>
</cfprocessingdirective>