<cfcomponent displayname="XMLutils" namespace="XMLutils" output="no">
	<!--- Global functionality for XML creation: deciding on plural node names -Dg--->

	<cffunction name="init" access="public" output="no" returntype="any">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getNodePlural" access="public" output="no" >
		<cfargument name="ThisNode" type="string" required="yes" />
		<cfset var Plural = "" />			
		<cfif PluralExceptions(ThisNode) neq "" >
			<cfset plural = PluralExceptions(ThisNode)>
		<cfelseif right(ThisNode,2) eq 'ey'>
			<cfset plural = left(ThisNode,(len(ThisNode)-2)) & "IES" />
		<cfelseif right(ThisNode,1) eq 'y'>
			<cfset plural = left(ThisNode,(len(ThisNode)-1)) & "IES" />
		<cfelseif right(ThisNode,1) eq 's'>
			<cfset plural = ThisNode & "ES" />
		<cfelse>
			<cfset Plural = ThisNode & "S" />
		</cfif>
		<cfreturn NodeNameCheck(Plural) />
	</cffunction>
	
	<cffunction name="PluralExceptions" access="private" output="no" >
		<cfargument name="ThisNode" type="string" required="yes" />
		<cfset var Plural = "" />	
		<!--- 1st pass at naming.  --->
		<cfswitch expression="#ucase(arguments.ThisNode)#">
			<cfcase value="SURVEY">
				<cfset Plural = "SURVEYS" />	
			</cfcase>			
			<cfcase value="METADATA">
				<cfset Plural = "METADATA" />	
			</cfcase>
			<cfdefaultcase>
				<cfset Plural = "" />	
			</cfdefaultcase>
		</cfswitch>
		<cfreturn ucase(Plural) />
	</cffunction>
	
	<cffunction name="NodeNameCheck" access="public" output="no" >
		<cfargument name="ThisNode" type="string" required="yes" />
		<cfset var rename = "" />	
		<!--- For adding hacks/ renaming nodes. --->
		<!--- 
			A trick here is that you could let things get missnamed in the plural exceptions list, 
			then fix them here if you need to. 
			For example: 
				"related_images" plural is "related_imageses" the sub-node of this is "related_image" which plural is "related_images" 
				We'd need to let "related_images" get missnamed then fix both afterwards so that we can filter properly. 
			--->
		<cfswitch expression="#ucase(arguments.ThisNode)#">
			<cfcase value="IMAGESES">
				<cfset rename = "IMAGES" />	
			</cfcase>
			<cfcase value="IMAGES">
				<cfset rename = "IMAGE" />	
			</cfcase>
			<cfdefaultcase>
				<cfset rename = arguments.ThisNode />	
			</cfdefaultcase>
		</cfswitch>
		<cfreturn ucase(rename) />
	</cffunction>
</cfcomponent>