<cfcomponent output="false">

	<cfset variables.config=""/>
	
	<cffunction name="init" returntype="any" access="public" output="false">
		<cfargument name="config"  type="any" default="">
		<cfset variables.config = arguments.config>
	</cffunction>
	
	<cffunction name="install" returntype="void" access="public" output="false">
		<cfset var sql = "">
		<cfset var x = "">
		<cfset var aSql = "">
		
        <cfif application.configBean.getDBType() eq "mysql">
            <cfsavecontent variable="sql">
                <cfinclude template="./dbScripts/mysqlInstall.cfm">
            </cfsavecontent>
            
            <cfset aSql = ListToArray(sql, ';')>
    
            <cfloop index="x" from="1" to="#arrayLen(aSql) - 1#">
                <cfquery datasource="#application.configBean.getDatasource()#">
                    #keepSingleQuotes(aSql[x])#
                </cfquery>
            </cfloop>
            
            <cfquery datasource="#application.configBean.getDatasource()#">
                CREATE TABLE `sp#variables.config.getPluginID()#_survey_object` (
                  `surveyID` VARCHAR(35) NOT NULL,
                  `objectID` VARCHAR(35) NOT NULL,
                  PRIMARY KEY (`surveyID`, `objectID`)
                )
                ENGINE = InnoDB;
            </cfquery>
        <cfelseif application.configBean.getDBType() eq "mssql">
        	<cfsavecontent variable="sql">
                <cfinclude template="./dbScripts/mssqlInstall.cfm">
            </cfsavecontent>
    
            <cfquery datasource="#application.configBean.getDatasource()#">
                #keepSingleQuotes(sql)#
            </cfquery>
            
            <cfquery datasource="#application.configBean.getDatasource()#">
				CREATE TABLE [dbo].[sp#variables.config.getPluginID()#_survey_object] (
					[surveyID] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
					[objectID] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
				)
            </cfquery>
        <cfelse>
        	<h1>Only MySQL and Microsoft SQL Server are supported.</h1>
        	<cfabort>
        </cfif>
        
        <cfset update()>
		
	</cffunction>
	
	<cffunction name="update" returntype="void" access="public" output="false">
		<cfset var sql = "">
		<cfset var x = "">
		<cfset var aSql = "">
		
        <cfif application.configBean.getDBType() eq "mysql">
            <cfsavecontent variable="sql">
                <cfinclude template="./dbScripts/updates/mysql.cfm">
            </cfsavecontent>
            
            <cfset aSql = ListToArray(sql, ';')>
    
            <cfloop index="x" from="1" to="#arrayLen(aSql) - 1#">
                <cftry>
	                <cfquery datasource="#application.configBean.getDatasource()#">
	                    #keepSingleQuotes(aSql[x])#
	                </cfquery>
                	<cfcatch></cfcatch>
            	</cftry>
            </cfloop>
            
        <cfelseif application.configBean.getDBType() eq "mssql">
        	<cfsavecontent variable="sql">
                <cfinclude template="./dbScripts/updates/mssql.cfm">
            </cfsavecontent>
    
            <cftry>
	            <cfquery datasource="#application.configBean.getDatasource()#">
	                #keepSingleQuotes(sql)#
	            </cfquery>
            	<cfcatch></cfcatch>
            </cftry>
            
        <cfelse>
        	<h1>Only MySQL and Microsoft SQL Server are supported.</h1>
        	<cfabort>
        </cfif>
        
		
	</cffunction>
	
	<cffunction name="delete" returntype="void" access="public" output="false">
		<cfset var sql = "">
		<cfset var x = "">
		<cfset var aSql = "">
		
		<cfif application.configBean.getDBType() eq "mysql">
            <cfsavecontent variable="sql">
                <cfinclude template="./dbScripts/mysqlDelete.cfm">
            </cfsavecontent>
            
            <cfset aSql = ListToArray(sql, ';')>
            
            <cfloop index="x" from="1" to="#arrayLen(aSql) - 1#">
                <cfquery datasource="#application.configBean.getDatasource()#">
                    #keepSingleQuotes(aSql[x])#
                </cfquery>		
            </cfloop>
            
            <cfquery datasource="#application.configBean.getDatasource()#">
                DROP TABLE IF EXISTS `sp#variables.config.getPluginID()#_survey_object`;
            </cfquery>
        <cfelseif application.configBean.getDBType() eq "mssql">
        	<cfsavecontent variable="sql">
                <cfinclude template="./dbScripts/mssqlDelete.cfm">
            </cfsavecontent>
        
            <cfquery datasource="#application.configBean.getDatasource()#">
                #keepSingleQuotes(aSql[x])#
            </cfquery>		
            
            <cfquery datasource="#application.configBean.getDatasource()#">
                DROP TABLE sp#variables.config.getPluginID()#_survey_object
            </cfquery>
        <cfelse>
        	<h1>Only MySQL and Microsoft SQL Server are supported.</h1>
        	<cfabort>
        </cfif>
	</cffunction>
	
	<cffunction name="keepSingleQuotes" returntype="string" output="false">
		<cfargument name="str">
		<cfreturn preserveSingleQuotes(arguments.str)>
	</cffunction>
	

</cfcomponent>
