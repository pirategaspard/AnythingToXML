﻿<cfcomponent namespace="QueryToXML" displayname="QueryToXML" output="no" >
	<!--- Query to XML by Daniel Gaspar <daniel.gaspar@gmail.com> 5/1/2008 --->

	<cffunction name="init" access="public" output="no" returntype="any">
		<cfargument name="XMLutils" type="any" required="yes" />
		<cfargument name="TabUtils" type="any" required="yes" />
		<cfset variables.XMLutils = arguments.XMLutils />
		<cfset variables.TabUtils = arguments.TabUtils />
		<cfreturn this>
	</cffunction>		
	
	<cffunction name="setAnythingToXML" access="public" output="no" returntype="void">
		<cfargument name="AnythingToXML" type="any" required="yes" />
		<cfset variables.AnythingToXML = arguments.AnythingToXML />
	</cffunction>
						
	<cffunction name="QueryToXML" access="public" output="no" returntype="string" >
		<cfargument name="ThisQuery" type="Query" required="yes">
		<cfargument name="rootNodeName" type="string" required="no" default="">
		<cfargument name="AttributeList" type="string" required="no" default="">
		<cfset var xmlString = "" />	
		<cfset var i = 1 />		
			
		<cfsetting enablecfoutputonly="yes">
		<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="xmlString" >
				<cfoutput>#variables.TabUtils.printtabs()#<#variables.XMLutils.getNodePlural(arguments.rootNodeName)#></cfoutput>
				<cfset variables.TabUtils.addtab() />		
				<cfloop query="arguments.ThisQuery" >
						<cfoutput>#variables.TabUtils.printtabs()#</cfoutput>
						<cfoutput><#addNodeAttributes(arguments.rootNodeName,arguments.ThisQuery.columnlist,arguments.ThisQuery,arguments.AttributeList)#></cfoutput>
						<cfoutput>#createXML(arguments.ThisQuery,arguments.rootNodeName,arguments.AttributeList)#</cfoutput>
						<cfoutput>#variables.TabUtils.printtabs()#</#arguments.rootNodeName#></cfoutput>
				</cfloop>
				<cfset variables.TabUtils.removetab() />	
				<cfoutput>#variables.TabUtils.printtabs()#</#variables.XMLutils.getNodePlural(arguments.rootNodeName)#></cfoutput>
			</cfsavecontent>
		</cfprocessingdirective>
		<cfreturn xmlString />
	</cffunction>
	
	<cffunction name="createXML" access="public" output="no" returntype="string">
		<cfargument name="thisQuery" type="Query" required="yes">
		<cfargument name="rootNodeName" type="string" required="no" default="">
		<cfargument name="AttributeList" type="string" required="no" default="">
		<cfset var aColumns = ListToArray(thisQuery.columnList) />
		<cfset var thisSize = aColumns.size() />
		<cfset var xmlString = "" />	
		<cfset var i = 1 />			
		<cfset variables.TabUtils.addtab() />				
		<cfsetting enablecfoutputonly="yes">
		<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="xmlString" >
				<cfloop from="1" to="#thisSize#" index="i" >			
					<cfif IsSimpleValue(evaluate("thisQuery." & aColumns[i]))>
						<cfif not ListFindNoCase(arguments.AttributeList,aColumns[i])>
							<cfoutput>#variables.TabUtils.printtabs()#<#aColumns[i]#><![CDATA[#evaluate("thisQuery." & aColumns[i])#]]></#aColumns[i]#></cfoutput>					
						</cfif>
					<cfelse>	
						<!--- Yay for Recursion!--->	
						<cfoutput>#variables.AnythingToXML.ToXML(evaluate("thisQuery." & aColumns[i]), aColumns[i],arguments.AttributeList)#</cfoutput>
					</cfif>
				</cfloop>	
			</cfsavecontent>
		</cfprocessingdirective>		
		<cfset variables.TabUtils.removetab() />		
		<cfreturn xmlString />
	</cffunction>
	
	<cffunction name="addNodeAttributes" access="public" output="no" returntype="string" >
		<cfargument name="thisNode" required="yes" type="string" hint="Name of XML the Tag" />
		<cfargument name="thisKeyList" required="yes" type="string" hint="List of Column names, Struct Keys, object properties" />		
		<cfargument name="thisElement" required="yes" type="any" hint="a Query or a Struct" />	
		<cfargument name="thisAttributeList" required="yes" type="string" hint="List of Column Names/Struct Keys that should become Attributes of the XML Node" />
		<cfset var returnString = arguments.thisNode />
		<cfset var i = 1 />				
					
		<cfloop from="1"  to="#ListLen(arguments.thisAttributeList)#" index="i">
			<cfif ListFindNoCase(arguments.thisKeyList, ListGetAt(arguments.thisAttributeList,i), ',' )>			
				<cfset returnString = returnString & ' ' & ListGetAt(arguments.thisAttributeList,i) & '="' />								
				<cfset returnString = returnString & xmlformat(evaluate("arguments.thisElement." & ListGetAt(arguments.thisAttributeList,i))) & '"' />		
			</cfif>
		</cfloop>
								
		<cfreturn returnString />
	</cffunction>
				
</cfcomponent>