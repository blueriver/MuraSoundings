<cfif request.pluginConfig.getSetting("pluginMode") eq "Admin">
	<!--- entry via admin--->
	<cflocation url="admin" addtoken="no">
<cfelse>
	<!--- entry via display object --->
	<cfinclude template="ApplicationProxy.cfm">
	<cfset request.pluginConfig.addToHTMLHeadQueue("htmlHead.cfm")>
	
	<!--- check for surveyID when display object is a single survey --->
	<cfquery name="rsSurveyCheck" datasource="#application.configBean.getDatasource()#">
		select surveyID from sp#request.pluginConfig.getPluginID()#_survey_object
		where
		objectID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectID#">
	</cfquery>
	<cfif rsSurveyCheck.recordCount gt 0>
		<cfset url.id = rsSurveyCheck.surveyID>
	</cfif>
	<!--- --->
	
	
	<!--- 
		if a single survey is not selected, then show active surveys (dsp_list.cfm)
		otherwise, find the ID and show survey.cfm
	--->
	<cfset hasError = false>

	<cfif not isDefined("url.id") or not len(url.id)>
		<cfinclude template="dsp_list.cfm">
	<cfelse>
		<cftry>
			<cfset survey = request.pApp.survey.getSurvey(url.id)>
			<cfif not survey.active or (survey.datebegin neq "" and dateCompare(survey.datebegin,now()) is 1) or 
					(survey.dateend neq "" and dateCompare(now(), survey.dateend) is 1)>
				<p><strong>This survey is not active, or has expired.</strong></p>
				<cfset hasError = true>
			</cfif>
			<cfif survey.templateidfk neq "">
				<cfset template = request.pApp.template.getTemplate(survey.templateidfk)>
			</cfif>
			<cfcatch>
				<p><strong>An error has occured with the survey.</strong></p>
				<cfset hasError = true>
			</cfcatch>
		</cftry>
		
		<cfif not hasError>
			<cfset url.embed = true>
			<cfinclude template="survey.cfm">
		</cfif>
	</cfif>
	<!--- --->
</cfif>

