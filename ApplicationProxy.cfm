<cfsetting enablecfoutputonly=true showdebugoutput=false>
<!---
	Name         : Application.cfm
	Author       : Raymond Camden 
	Created      : September 2, 2004
	Last Updated : August 3, 2007
	History      : change application.cfc to soundings.cfc
				 : Stupid IE. If you hit ENTER instead of clicking the button, it wouldn't send the value. (rkc 3/1/06)
				 : work w/o mapping (rkc 3/10/06)
				 : user changes (rkc 8/3/07)
	Purpose		 : 
--->


<cfset pApp=request.pluginConfig.getApplication() />
<cfset pSession=request.pluginConfig.getSession() />


<cfif not pApp.valueExists("init") or structKeyExists(url,"reinit")>

	<!--- Get main settings --->
	<cfset pApp.setValue("soundings",createObject("component","cfcs.soundings"))>
	<cfset pApp.setValue("settings",pApp.getValue("soundings").getSettings())>
	
	<!--- Mura plugin --->
	<cfset pApp.getValue("settings").dsn = application.configBean.getDatasource()>
	<cfset pApp.getValue("settings").dbtype = application.configBean.getDBType()>
	<cfset pApp.getValue("settings").fromaddress = application.configBean.getAdminEmail()>
	<cfset pApp.getValue("settings").tableprefix = "sp" & request.pluginConfig.getPluginID() & "_">
	<!--- --->
		
	<cfset pApp.setValue("survey",createObject("component","cfcs.surveyProxy").init(pApp.getValue("settings")))>
	<cfset pApp.setValue("question",createObject("component","cfcs.question").init(pApp.getValue("settings")))>
	<cfset pApp.setValue("questiontype",createObject("component","cfcs.questiontype").init(pApp.getValue("settings")))>
	<cfset pApp.setValue("template",createObject("component","cfcs.template").init(pApp.getValue("settings")))>
	<cfset pApp.setValue("user",createObject("component","cfcs.user").init(pApp.getValue("settings")))>
	<cfset pApp.setValue("utils",createObject("component","cfcs.utils"))>
	<cfset pApp.setValue("toxml",createObject("component","cfcs.toxml"))>
	
	<cfset request.pSession.surveys = structNew()>
	<cfset pApp.setValue("init",true)>
	
</cfif>

<cfset request.pApp=pApp.getAllValues() />
<cfset request.pSession=pSession.getAllValues() />

<!--- include UDFs --->
<cfinclude template="includes/udf.cfm">

<cfif isDefined("url.logout")>
	<cfset structDelete(request.pSession, "loggedin")>
</cfif>

<!--- handle security --->
<cfif not request.udf.isLoggedOn()>

	<!--- are we trying to logon? --->
	<cfif isDefined("form.username") and isDefined("form.password")>
		<cfif request.pApp.user.authenticate(form.username,form.password)>
			<cfset request.pSession.user = request.pApp.user.getUser(form.username)>
			<cfset request.pSession.loggedin = true>
		</cfif>
	</cfif>
	
</cfif>

<cfsetting enablecfoutputonly=false>