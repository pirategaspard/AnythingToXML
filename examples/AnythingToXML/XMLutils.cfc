<cfcomponent displayname="XMLutils" namespace="XMLutils" output="no">
	<!--- XML Utility functions by Daniel Gaspar <daniel.gaspar@gmail.com> 5/1/2008 --->
	<!--- Global functionality for XML creation: deciding on plural node names -Dg--->

	<cffunction name="init" access="public" output="no" returntype="any">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getNodePlural" access="public" output="no" >
		<cfargument name="ThisNode" type="string" required="yes" />
		<cfset var Plural = "" />		
		<cfif right(ThisNode,2) eq 'ey'>
			<cfset plural = left(ThisNode,(len(ThisNode)-2)) & "IES" />
		<cfelseif right(ThisNode,1) eq 'y'>
			<cfset plural = left(ThisNode,(len(ThisNode)-1)) & "IES" />
		<cfelseif right(ThisNode,1) eq 's'>
			<cfset plural = ThisNode & "ES" />
		<cfelse>
				<cfset Plural = ThisNode & "S" />
		</cfif>
		<cfreturn Plural />
	</cffunction>
	
</cfcomponent>