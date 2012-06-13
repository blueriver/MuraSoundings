<cfscript>
if(not isDefined("pluginConfig")){
	package=listFirst(
			listGetat(
				getDirectoryFromPath(getCurrentTemplatePath()),
				listLen(
					getDirectoryFromPath(getCurrentTemplatePath()),
					application.configBean.getFileDelim())-1,
					application.configBean.getFileDelim()
				),
		"_");	
		
	pluginConfig=application.pluginManager.getConfig(package);
}

if(not structKeyExists(session,"siteID") 
	or not application.permUtility.getModulePerm(pluginConfig.getValue('moduleID'),session.siteID)){

	location("#application.configBean.getContext()#/admin/",false);
}

if(not isDefined("$")){
	application.serviceFactory.getBean("muraScope").init(session.siteID);	
}

request.pluginConfig=pluginconfig;
</cfscript>