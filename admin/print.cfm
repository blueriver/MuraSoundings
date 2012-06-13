<cfsetting enablecfoutputonly=true>
<!---
	Name         : survey_edit.cfm
	Author       : Raymond Camden 
	Created      : September 7, 2004
	Last Updated : March 30, 2006
	History      : support for clearing results (rkc 3/30/06)
--->
<cfimport taglib="../tags/" prefix="tags">

<cfif not structKeyExists(url, "id")>
	<cflocation url="index.cfm" addToken="false">
</cfif>

<cfif not request.pSession.user.isAdmin>
	<cfset survey = request.pApp.survey.getSurvey(url.id, request.pSession.user.id)>
<cfelse>
	<cfset survey = request.pApp.survey.getSurvey(url.id)>
</cfif>

<cfset questions = request.pApp.question.getQuestions(url.id)>		

<cfsavecontent variable="output">
<cfoutput>
<html>

<head>
<style>
.box {
	border: thin solid rgb(0,0,0);
	width: 500px;
	height: 100px;
}
</style>
</head>	
<body>

<h1>#survey.name#</h1>
</cfoutput>

<cfloop query="questions" endrow="3">
		<cfset questionob = request.pApp.question.getQuestions(url.id, currentRow)>		

		<cfmodule template="../handlers/#handlerRoot#/print.cfm" 
			step="#currentRow#" question="#questionob#" />

</cfloop>

<cfoutput>
</body>
</html>
</cfoutput>

</cfsavecontent>
<cfif 1>
<cfoutput>#output# <hr>#htmlCodeFormat(output)#</cfoutput><cfabort>
</cfif>
<cfdocument format="pdf" name="content"><cfoutput>#output#</cfoutput></cfdocument>

<cfheader name="Content-Disposition" value="inline; filename=survey.pdf">
<cfcontent type="application/pdf" reset="true" variable="#content#">


<cfsetting enablecfoutputonly=false>