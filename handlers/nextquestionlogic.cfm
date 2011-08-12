<cfset extra = structNew()>
<cfif structKeyExists(form, "nextquestionaction") and form.nextquestionaction is "goto">
	<cfset extra.nextquestion = form.nextquestion>
	<cfif structKeyexists(form, "questionfilter") and form.questionfilter is "onlyif">
		<cfset extra.nextquestionvalue = form.nextquestionvalue>
	<cfelse>
		<cfset extra.nextquestionvalue = "">
	</cfif>
</cfif>
