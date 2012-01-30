<cfoutput>
ALTER TABLE `sp#variables.config.getPluginID()#_questions` ADD COLUMN `nextquestion` VARCHAR(35) NULL  AFTER `required` , ADD COLUMN `nextquestionvalue` VARCHAR(255) NULL  AFTER `nextquestion`
;
ALTER TABLE `sp#variables.config.getPluginID()#_surveys` ADD COLUMN `questionsperpage` INT NULL  AFTER `showinpubliclist`
;
CREATE TABLE `sp#variables.config.getPluginID()#_questionbranches`  ( 
	id               	varchar(35) NOT NULL,
	questionidfk     	varchar(35) NOT NULL,
	nextquestion     	varchar(35) NOT NULL,
	nextquestionvalue	varchar(255) NOT NULL,
	rank             	int(11) NOT NULL,
	PRIMARY KEY(id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
</cfoutput>