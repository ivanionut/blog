component extends="lib.framework"  {

	this.sessionmanagement = true;
    this.sessionTimeout = CreateTimeSpan(0,0,30,30);
    this.sessionStorage = "memory";
	this.datasource = "blograsia";
	this.ormEnabled = true;
	this.ormSettings = { logsql : true };
	this.invokeImplicitAccessor = true;
    this.datasources["blograsia"] = {
		  class: 'org.gjt.mm.mysql.Driver'
		, connectionString: 'jdbc:mysql://172.16.0.68:3306/blograsia?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true'
		, username: 'dev'
		, password: "encrypted:32349688406fb41c00cb1d5618a0b6a6c5c5d7387fb92267"
	};    
    
	this.tag.cflocation.addtoken = false;
	this.mappings["/modules"]=ExpandPath("./path/to/modules");
	variables.framework = {
		base= "/blog"
	};
		
	function setupApplication() {
		ORMReload();
		return;
	}	
	
	function setupSession() {
	 	SESSION.isLoggedIn = false;
	 	SESSION.bloggerId = 0;
	 	SESSION.bloggerName = "";
		return;
	}
}