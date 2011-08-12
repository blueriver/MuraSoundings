<cfoutput>
ALTER TABLE `sp#variables.config.getPluginID()#_questions` ADD COLUMN `nextquestion` VARCHAR(35) NULL  AFTER `required` , ADD COLUMN `nextquestionvalue` VARCHAR(255) NULL  AFTER `nextquestion`
;
ALTER TABLE `sp#variables.config.getPluginID()#_surveys` ADD COLUMN `questionsperpage` INT NULL  AFTER `showinpubliclist`
</cfoutput>