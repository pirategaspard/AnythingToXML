<cfcomponent>
	
	<!--- customer object for object to XML example. --->
	
	<cfproperty name="customerid" type="string" />
	<cfproperty name="Firstname" type="string" />
	<cfproperty name="Lastname" type="string" />
	
	<cffunction name="init" access="public" returntype="any">
		<cfargument name="Firstname" type="string" required="no" default="John">
		<cfargument name="Lastname" type="string" required="no" default="Doe">
		<cfset this.Firstname=arguments.Firstname />
		<cfset this.Lastname=arguments.Lastname />
		<cfset this.customerid= createUUID() />
		<cfreturn this>
	</cffunction>
</cfcomponent>