<cfcomponent displayname="TabUtils" namespace="TabUtils" output="no">
	<!---  Keeps track of tabs 'n prints them	-Dg--->

	<cfproperty name="tabs" default="0" type="numeric" />
	
	<cffunction name="init" access="public" output="no" returntype="any">
		<cfargument name="tabs" type="numeric" required="no" default="0" />
		<cfset this.tabs = arguments.tabs />	
		<cfreturn this>
	</cffunction>
	
	<cffunction name="setTabs" access="public" output="no" returntype="any">
		<cfargument name="tabs" type="numeric" required="no" default="#this.tabs#" />
		<cfset this.tabs = arguments.tabs />	
	</cffunction>
	
	<cffunction name="addtab" access="public" output="no" returntype="void">
		<cfargument name="num" type="numeric" required="no" default="1" />
		<cfset this.tabs = this.tabs  + arguments.num />		
	</cffunction>
	
	<cffunction name="removetab" access="public" output="no" returntype="void">
		<cfargument name="num" type="numeric" required="no" default="1" />
		<cfset this.tabs = this.tabs  - arguments.num />		
	</cffunction>	
		
	<cffunction name="printtabs" access="public" output="no" returntype="string" >
		<cfargument name="tabs" type="numeric" required="no" default="#this.tabs#" />
		<cfset var returnstring = "" />
		<cfset var i = 1 />	
		<!---<cfif this.tabs gt 0 >	--->
		<cfprocessingdirective suppresswhitespace="yes">
			<cfsetting enablecfoutputonly="yes">
			<cfsavecontent variable="returnstring" >				
				<cfoutput>#chr(10)#</cfoutput>				
				<cfloop from="1" to="#arguments.tabs#" index="i" >
					<cfoutput>#chr(09)#</cfoutput>
				</cfloop>				
			</cfsavecontent>
		</cfprocessingdirective>
		<!---</cfif>--->
		<cfreturn returnstring>
	</cffunction>
</cfcomponent>