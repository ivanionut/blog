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
	, connectionString: 'jdbc:mysql://127.0.0.1:3306/blograsia?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true'
	, username: 'root'
	, password: "encrypted:27a2edff8ea1b23db3c4dbc5e1e9feb1e6314ed912a7c26e"
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
		return;
	}
}