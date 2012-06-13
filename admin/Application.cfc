<cfcomponent output="false">
	
	<cfinclude template="../../../config/applicationSettings.cfm">
	
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">


		<cfinclude template="../../../config/settings.cfm">
		<cfinclude template="../plugin/config.cfm" />
		<cfinclude template="../ApplicationProxy.cfm">
		
		<cfif not request.udf.isLoggedOn()>
			<cfset userBean = application.userManager.read(session.mura.userid)>
			<cfset user = request.pApp.user.getUser(userBean.getUsername())>
			
			<cfif user.username eq "">
				<cfset data = structNew()>
				<cfset data.username = userBean.getUsername()>
				<cfset data.password = "password">
				<cfset data.isAdmin = 1>
				<cfset request.pApp.user.addUser(argumentCollection=data)>
			</cfif>
			
			<cfset request.prequest.pSession.user = request.pApp.user.getUser(userBean.getUsername())>
			<cfset request.pSession.loggedin = true>
		</cfif>

		<cfreturn true>
	</cffunction>
	

</cfcomponent>
