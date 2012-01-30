<cfcomponent extends="survey">
	<cffunction name="addSurvey" access="public" returnType="uuid" output="false"
				hint="Adds a new survey.">
		<cfargument name="name" type="string" required="true" hint="Survey name.">
		<cfargument name="description" type="string" required="true" hint="Survey description.">
		<cfargument name="active" type="boolean" required="true" hint="Determines if the survey is active or not.">
		<cfargument name="dateBegin" type="date" required="false" hint="Time when survey begins.">
		<cfargument name="dateEnd" type="date" required="false" hint="Time when survey ends.">
		<cfargument name="resultMailto" type="string" required="false" hint="Email address to send results to.">
		<cfargument name="surveyPassword" type="string" required="false" hint="Survey password necessary for access.">
		<cfargument name="thankYouMsg" type="string" required="false" hint="Survey thank you message.">
		<cfargument name="allowembed" type="boolean" required="false" hint="Allow the survey to be embedded.">
		<cfargument name="showinpubliclist" type="string" required="false" hint="Survey shows up on home page.">
		<cfargument name="templateidfk" type="any" required="false" hint="Template.">
		<cfargument name="useridfk" type="any" required="false" hint="Template.">
		<cfargument name="questionsperpage" type="any" required="false">
		
		<cfset var surveyID = super.addSurvey(argumentCollection=arguments)>
		<!---<cfset var surveyID = super.addSurvey(name, description, active, dateBegin, dateEnd, resultMailto, surveyPassword, thankYouMsg, allowembed, showinpubliclist, templateidfk, useridfk)>--->
		<cfset var objectID = createUUID()>
		<cfset var pdoBean = application.pluginManager.getDisplayObjectBean()>
		
		<cfquery datasource="#variables.dsn#">
			insert into #variables.tableprefix#survey_object 
			(surveyID, objectID)
			values
			(<cfqueryparam cfsqltype="cf_sql_varchar" value="#surveyID#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#objectID#">)
		</cfquery>
		
		<cfset pdoBean.setObjectID(objectID)>
		<cfset pdoBean.setName(name)>
		<cfset pdoBean.setDisplayObjectFile("index.cfm")>
		<cfset pdoBean.setModuleID(request.pluginConfig.getModuleID())>
		<cfset pdoBean.save()>
		
		<cfset application.pluginManager.loadPlugins()>
		
		<cfreturn surveyID>
		
	</cffunction>
	
	<cffunction name="deleteSurvey" access="public" returnType="void" output="false"
				hint="Deletes a survey. Also does cleanup on results/questions/answers.">
		<cfargument name="id" type="uuid" required="true" hint="The UUID of the survey to delete.">
		<cfargument name="useridfk" type="uuid" required="false">
		<cfset var pdoBean = application.pluginManager.getDisplayObjectBean()>
		<cfset var rsO = "">
		
		<cfquery name="rsO" datasource="#variables.dsn#">
			select objectID from #variables.tableprefix#survey_object 
			where
			surveyID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#id#">
		</cfquery>
		
		<cfset pdoBean.setObjectID(rsO.objectID)>
		<cfset pdoBean.delete()>
		
		<cfquery datasource="#variables.dsn#">
			delete from #variables.tableprefix#survey_object 
			where
			surveyID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#id#">
		</cfquery>
		
		<cfset application.pluginManager.loadPlugins()>
		
		<cfset super.deleteSurvey(argumentCollection=arguments)>
	</cffunction>
	
</cfcomponent>