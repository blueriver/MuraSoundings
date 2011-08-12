<cfif attributes.questions.recordCount lt 2>
	<cfexit>
</cfif>

<!--- 
todo - if no more questions, abort
--->
<script>
$(document).ready(function() {

	$("#nextquestionaction").change(function() {
		var selvalue = $("#nextquestionaction option:selected").val();
		console.log("changed it to "+selvalue);
		if (selvalue == "goto") {
			$("#nextquestionlistarea").show();
		} else {
			$("#nextquestionlistarea").hide();
		}
	});

	$("#questionfilter").change(function() {
		var selvalue = $("option:selected", this).val();
		console.log("changed it to "+selvalue);
		if (selvalue == "onlyif") {
			$("#nextquestionvaluearea").show();
		} else {
			$("#nextquestionvaluearea").hide();
		}
	});

});
</script>

<cfset showblock = false>
<cfset showanswerblock = false>
<cfparam name="form.questionfilter" default="">
<cfif not structKeyExists(form, "nextquestionaction") and structKeyExists(attributes, "question")>
	<cfif attributes.question.nextquestion neq "">
		<cfset form.nextquestionaction = "goto">
		<cfset showblock = true>
	<cfelse>
		<cfset form.nextquestionaction = "">
	</cfif>
	<cfif attributes.question.nextquestionvalue is not "">
		<cfparam name="form.nextquestionvalue" default="#attributes.question.nextquestionvalue#">
		<cfset form.questionfilter = "onlyif">
		<cfset showanswerblock = true>
	<cfelse>
		<cfparam name="form.nextquestionvalue" default="">
	</cfif>
	<cfparam name="form.nextquestion" default="#attributes.question.nextquestion#">
<cfelse>
	<cfparam name="form.nextquestion" default="">
	<cfparam name="form.nextquestionaction" default="">
	<cfparam name="form.nextquestionvalue" default="">
</cfif>

<cfoutput>
<tr>
	<td colspan="2">
	<p>
	<b>Post Question Action</b>
	</p>
	When the question is answered 
	<select name="nextquestionaction" id="nextquestionaction">
	<option value="" <cfif form.nextquestionaction is "">selected</cfif>>do nothing</option>
	<option value="goto" <cfif form.nextquestionaction is "goto">selected</cfif>>go to</option>
	</select>
	
	<span id="nextquestionlistarea" <cfif not showblock>style="display:none"</cfif>>

		question
		<select name="nextquestion" id="nextquestionlist">
			<cfloop query="attributes.questions">
				<cfif not structKeyExists(attributes, "question")
					or (structKeyExists(attributes, "question") and id neq attributes.question.id)>
				<option value="#id#" <cfif form.nextquestion is id>selected</cfif>>#question#</option>
				</cfif>
			</cfloop>
		</select>
		
		<!---
		We allow you to filter by answer ONLY on
		truefalse+yesno
		MC
		--->
		<cfset qt = attributes.questiontype.name>
		<cfset filterOkList = "Yes/No,True/False,Multiple Choice (Single Selection),Multiple Choice (Single Selection) with Other">
		
		<cfif listFindNoCase(filterOkList, qt)>
			<select id="questionfilter" name="questionfilter">
			<option value="" <cfif form.questionfilter is "">selected</cfif>></option>
			<option value="onlyif" <cfif form.questionfilter is "onlyif">selected</cfif>>only if the answer is</option>
			</select>
	
			<!--- possible answers depends on type --->
			<span id="nextquestionvaluearea" <cfif not showanswerblock>style="display:none"</cfif>>
			<cfswitch expression="#qt#">
				<cfcase value="Yes/No,True/False">
					<select name="nextquestionvalue">
					<option value="1" <cfif isBoolean(form.nextquestionvalue) and form.nextquestionvalue>selected</cfif>><cfif qt is "Yes/No">Yes<cfelse>True</cfif></option>
					<option value="0" <cfif isBoolean(form.nextquestionvalue) and not form.nextquestionvalue>selected</cfif>><cfif qt is "Yes/No">No<cfelse>False</cfif></option>
					</select>
				</cfcase>
				<cfcase value="Multiple Choice (Single Selection),Multiple Choice (Single Selection) with Other">
					<select name="nextquestionvalue">
						<cfloop from="1" to="#arrayLen(answers)#" index="x">
							<option value="#answers[x].id#" <cfif form.nextquestionvalue is answers[x].id>selected</cfif>>#answers[x].answer#</option>
						</cfloop>
					</select>
				</cfcase>
				<!---
				Decided against supporting this - since you can say, go to N if you pick A, B, and a user may be pick
				A and C, I can't imagine this logic actually being something you want. May change my mind so
				I'm commenting it...
				<cfcase value="Multiple Choice (Multi Selection),Multiple Choice (Multi Selection) with Other">
					<select name="nextquestionvalue" multiple="true" size="4">
						<cfloop from="1" to="#arrayLen(answers)#" index="x">
							<option value="#answers[x].id#" <cfif listFind(form.nextquestionvalue,answers[x].id)>selected</cfif>>#answers[x].answer#</option>
						</cfloop>
					</select>
				</cfcase>
				--->
			</cfswitch>
			</span>
		</cfif>				
	</span>
	
	</td>
</tr>
</cfoutput>
