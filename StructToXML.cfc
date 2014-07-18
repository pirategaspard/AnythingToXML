<cfcomponent namespace="StructToXML" displayname="StructToXML" output="no" >

	<cffunction name="init" access="public" output="no" returntype="any">
		<cfargument name="Include_Type_Hinting" type="numeric" required="no" default="1" />
		<cfargument name="XMLutils" type="any" required="yes" />
		<cfargument name="TabUtils" type="any" required="yes" />
		<cfset variables.Include_Type_Hinting = arguments.Include_Type_Hinting />
		<cfset variables.XMLutils = arguments.XMLutils />
		<cfset variables.TabUtils = arguments.TabUtils />
		<cfreturn this>
	</cffunction>		
	
	<cffunction name="setAnythingToXML" access="public" output="no" returntype="void">
		<cfargument name="AnythingToXML" type="any" required="yes" />
		<cfset variables.AnythingToXML = arguments.AnythingToXML />
	</cffunction>
						
	<cffunction name="StructToXML" access="public" output="no" returntype="string" >
		<cfargument name="ThisStruct" type="struct" required="yes">
		<cfargument name="rootNodeName" type="string" required="no">
		<cfargument name="AttributeList" type="string" required="no" default="">
		<cfset var xmlString = "" />	
		<cfset var i = 1 />			
		
		<cfsetting enablecfoutputonly="yes">
		<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="xmlString" >
				<cfoutput>#variables.TabUtils.printtabs()#</cfoutput>
				<cfoutput><#addNodeAttributes(arguments.rootNodeName,StructKeyList(arguments.ThisStruct),arguments.ThisStruct,arguments.AttributeList)# <cfif variables.Include_Type_Hinting eq 1>CF_TYPE='struct'</cfif>></cfoutput>
				<cfoutput>#createXML(arguments.ThisStruct,arguments.rootNodeName,arguments.AttributeList)#</cfoutput>
				<cfoutput>#variables.TabUtils.printtabs()#</#variables.XMLutils.NodeNameCheck(arguments.rootNodeName)#></cfoutput>
			</cfsavecontent>
		</cfprocessingdirective>
		<cfreturn xmlString />
	</cffunction>
	
	<cffunction name="createXML" access="public" output="no" returntype="string">
		<cfargument name="thisStruct" type="struct" required="yes">
		<cfargument name="rootNodeName" type="string" required="no" default="">
		<cfargument name="AttributeList" type="string" required="no" default="">
		<cfset var aKeys = ListToArray(StructKeyList(arguments.thisStruct)) />
		<cfset var thisStructSize = StructCount(arguments.thisStruct) />
		<cfset var xmlString = "" />	
		<cfset var i = 1 />		
		<cfset var CurrentNode = '' />
		<cfset var hoisted = false />	
		<cfset variables.TabUtils.addtab() />				
		<cfsetting enablecfoutputonly="yes">
		<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="xmlString" >
				<cfloop from="1" to="#thisStructSize#" index="i" >
					<cfset hoisted = false />	
					<cfif (isStruct(thisStruct[aKeys[i]])) AND (Listlen(arguments.AttributeList) gt 0) >
						<!--- if this is a stuct, check to see if a child key is named the same as the parent node AND if it is a simple value. If so, hoist it up automatically. 
								This situation happens when you try to put attibute(s) on a simple value, you end up needing a structure to define it. --->
						<cfset stChild = thisStruct[aKeys[i]] />
						<cfset lChildKeys = StructKeyList(stChild) />
						<cfset pos = ListFindNoCase(lChildKeys,aKeys[i],',') />
						<cfif (pos gt 0) AND IsSimpleValue(stChild[aKeys[i]]) >								
							<!--- we have the situation where we should hoist the value to the parent level. <xml><blah id="1"><blah>abcd</blah></blah><xml> becomes <xml><blah id="1">abcd</blah><xml>.  --->
							<cfset hoisted = true />	
							<cfoutput>#variables.TabUtils.printtabs()#<#addNodeAttributes(aKeys[i],lChildKeys,stChild,arguments.AttributeList)# <cfif variables.Include_Type_Hinting eq 1>CF_TYPE='struct'</cfif>><![CDATA[#trim(stChild[aKeys[i]])#]]></#aKeys[i]#></cfoutput>		
						</cfif>					
					</cfif>					
					<cfif NOT hoisted >												
						<cfif IsSimpleValue(thisStruct[aKeys[i]])>
							<cfif not ListFindNoCase(arguments.AttributeList,aKeys[i])>
								<cfset CurrentNode = variables.XMLutils.NodeNameCheck(aKeys[i]) />
								<cfoutput>#variables.TabUtils.printtabs()#<#CurrentNode#><![CDATA[#trim(thisStruct[aKeys[i]])#]]></#CurrentNode#></cfoutput>					
							</cfif>
						<cfelse>																		
							<!--- Yay for Recursion!--->	
							<cfoutput>#variables.AnythingToXML.ToXML(thisStruct[aKeys[i]],aKeys[i],arguments.AttributeList)#</cfoutput>
						</cfif>					
					</cfif>										
				</cfloop>	
			</cfsavecontent>
		</cfprocessingdirective>		
		<cfset variables.TabUtils.removetab() />		
		<cfreturn xmlString />
	</cffunction>
	
	<cffunction name="doSimpleValue" access="public" output="no" returntype="string">
		
	</cffunction>

	<cffunction name="addNodeAttributes" access="public" output="no" returntype="string" >
		<cfargument name="thisNode" required="yes" type="string" hint="Name of XML the Tag" />
		<cfargument name="thisKeyList" required="yes" type="string" hint="List of Column names, Struct Keys, object properties" />		
		<cfargument name="thisElement" required="yes" type="any" hint="a Query or a Struct" />	
		<cfargument name="thisAttributeList" required="yes" type="string" hint="List of Column Names/Struct Keys that should become Attributes of the XML Node" />
		<cfset var returnString = variables.XMLutils.NodeNameCheck(arguments.thisNode) />
		<cfset var i = 1 />				
			
		<cfloop from="1"  to="#ListLen(arguments.thisAttributeList)#" index="i">
			<cfif ListFindNoCase(arguments.thisKeyList, ListGetAt(arguments.thisAttributeList,i), ',' )>			
				<cfset returnString = returnString & ' ' & lCase(ListGetAt(arguments.thisAttributeList,i)) & '="' />				
				<cfset returnString = returnString & xmlformat(arguments.thisElement[ListGetAt(arguments.thisAttributeList,i)]) & '"' />
			</cfif>				
		</cfloop>
								
		<cfreturn returnString />
	</cffunction>
			
</cfcomponent>