﻿<cfcomponent namespace="ObjectToXML" displayname="ObjectToXML" output="no" >
	<!--- Object to XML by Daniel Gaspar <daniel.gaspar@gmail.com> 5/1/2008 --->
	<!--- Limitation: This will only work on Objects with defined properties ex: <cfproperty name="userName" type="string" default="Bob"> --->

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
						
	<cffunction name="ObjectToXML" access="public" output="no" returntype="string" >
		<cfargument name="ThisObj" type="any" required="yes">
		<cfargument name="rootNodeName" type="string" required="no" default="">
		<cfargument name="AttributeList" type="string" required="no" default="">
		<cfset var xmlString = "" />	
		<cfset var i = 1 />		
		<cfset var AttributeCollection = getMetaData(arguments.ThisObj).properties />	
												
		<cfsetting enablecfoutputonly="yes">
		<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="xmlString" >
						<cfoutput>#variables.TabUtils.printtabs()#</cfoutput>
						<cfoutput><#addNodeAttributes(arguments.rootNodeName,AttributeCollection,arguments.ThisObj,arguments.AttributeList)#></cfoutput>
						<cfoutput>#createXML(arguments.ThisObj,arguments.rootNodeName,arguments.AttributeList)#</cfoutput>
						<cfoutput>#variables.TabUtils.printtabs()#</#arguments.rootNodeName#></cfoutput>
			</cfsavecontent>
		</cfprocessingdirective>
		<cfreturn xmlString />
	</cffunction>
	
	<cffunction name="createXML" access="public" output="no" returntype="string">
		<cfargument name="ThisObj" type="any" required="yes">
		<cfargument name="rootNodeName" type="string" required="no" default="">
		<cfargument name="AttributeList" type="string" required="no" default="">
		<cfset var aProperties = getMetaData(ThisObj).properties />
		<cfset var thisSize = ArrayLen(aProperties) />
		<cfset var xmlString = "" />	
		<cfset var i = 1 />	
						
		<cfset variables.TabUtils.addtab() />				
		<cfsetting enablecfoutputonly="yes">
		<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="xmlString" >
				<cfloop from="1" to="#thisSize#" index="i" >			
					<cfif structkeyexists(ThisObj, aProperties[i].name)>
						<cfif IsSimpleValue(evaluate("ThisObj." & aProperties[i].name))> 
							<cfif not ListFindNoCase(arguments.AttributeList,aProperties[i].name)>
								<cfoutput>#variables.TabUtils.printtabs()#</cfoutput>
								<cfoutput><#aProperties[i].name#><![CDATA[#evaluate("ThisObj." & aProperties[i].name)#]]></#aProperties[i].name#></cfoutput>					
							</cfif>
						<cfelse>		
								<!--- Yay for Recursion!--->	
								<cfoutput>#variables.AnythingToXML.ToXML(evaluate("ThisObj." & aProperties[i]), aProperties[i].name,arguments.AttributeList)#</cfoutput>
						</cfif>
					</cfif>
				</cfloop>	
			</cfsavecontent>
		</cfprocessingdirective>		
		<cfset variables.TabUtils.removetab() />		
		<cfreturn xmlString />
	</cffunction>
	
	<cffunction name="addNodeAttributes" access="public" output="no" returntype="string"  >
		<cfargument name="thisNode" required="yes" type="string" hint="Name of XML the Tag" />
		<cfargument name="thisKeyList" required="yes" type="string" hint="List of Column names, Struct Keys, object properties" />		
		<cfargument name="thisElement" required="yes" type="any" hint="a Query or a Struct" />	
		<cfargument name="thisAttributeList" required="yes" type="string" hint="List of Column Names/Struct Keys that should become Attributes of the XML Node" />
		<cfset var returnString = arguments.thisNode />
		<cfset var i = 1 />		
		
			
		<cfloop from="1" to="#arraylen(arguments.thisKeyList)#" index="j">
			<cfloop from="1"  to="#ListLen(arguments.thisAttributeList)#" index="i">		
				<cfif ListFindNoCase(arguments.thisKeyList[j].name, ListGetAt(arguments.thisAttributeList,i), ',' )>						
					
					<cfset returnString = returnString & ' ' & ListGetAt(arguments.thisAttributeList,i) & '="' />				
					<cfset returnString = returnString & xmlformat(evaluate("arguments.thisElement." & ListGetAt(arguments.thisAttributeList,i))) & '"' />			
				</cfif>
			</cfloop>
		</cfloop>		
						
		<cfreturn returnString />
	</cffunction>
				
</cfcomponent>