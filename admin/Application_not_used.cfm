<cfsetting enablecfoutputonly=true>
<!---
	Name         :  request.pApp.cfm
	Author       : Raymond Camden 
	Created      : September 2, 2004
	Last Updated : September 2, 2004
	History      : 
	Purpose		 : 
--->

<!--- include root app --->
<cfinclude template="../ request.pApp.cfm">

<cfif not request.udf.isLoggedOn()>
	<cfinclude template="login.cfm">
	<cfabort>
</cfif>

<cfsetting enablecfoutputonly=false>