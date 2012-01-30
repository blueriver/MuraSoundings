<cfoutput>
ALTER TABLE [dbo].[sp#variables.config.getPluginID()#_surveys] ADD [questionsperpage] [int] NULL

ALTER TABLE [dbo].[sp#variables.config.getPluginID()#_questions] ADD [nextquestion] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL

ALTER TABLE [dbo].[sp#variables.config.getPluginID()#_questions] ADD [nextquestionvalue] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL

CREATE TABLE [dbo].[sp#variables.config.getPluginID()#_questionbranches] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[questionidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[nextquestionvalue] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[nextquestion] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	
) ON [PRIMARY]
</cfoutput>