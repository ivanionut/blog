component output="false" displayname=""  {

	function init(required any fw){
		VARIABLES.fw = arguments.fw;
		return this;
	}
	
	function default(struct rc) {
		var conditionquery = "";
		if (StructKeyExists(rc,"categoryid") and (LSParseNumber(rc.categoryid) > 0)){
			conditionquery = " and find_in_set('"&rc.categoryid&"',bcc.listcategoryids)" ;
		}
		if(StructKeyExists(rc,"userid") and (LSParseNumber(rc.userid) > 0)){
			conditionquery = " and us.userID = #rc.userid# ";
		}
		if(StructKeyExists(rc,"keysearch")){
			conditionquery = " and (bp.title like '%#rc.keysearch#%' or bp.context like '%#rc.keysearch#%') ";
		}

		param name="URL.page"  default= 1 ;
		param name="rc.main_page"  default= "" ;
		param name="rc.limit"  default= 5 ;
		rc.idpage = (URL.page -1)*rc.limit;
		
		rc.count=QueryExecute(
			"SELECT count(*) as countblog
			FROM blogpost bp LEFT JOIN (SELECT COUNT(commentID) AS numofcomment, blogpostID 
				FROM blogcomment GROUP BY blogpostID) bgc ON bgc.blogpostID = bp.blogpostID 
				INNER JOIN ( SELECT bc.blogpostID,bc.categoryID, 
		GROUP_CONCAT(c.categoryname SEPARATOR ',') AS listcategorynames,
		GROUP_CONCAT(c.categoryID SEPARATOR ',') AS listcategoryids, COUNT(c.categoryID) AS numofcategory 
		FROM category c inner join blogpost_category bc on bc.categoryID = c.categoryID 
		GROUP BY bc.blogpostID)bcc 
		ON bcc.blogpostID = bp.blogpostID, user us 
		WHERE bp.userID = us.userID"& conditionquery &" 
		ORDER BY bp.status DESC, bp.created DESC");

		var no=0;
		if(isnull(rc.count)){
		 	no=0
		}
		else{
		 	no=rc.count.countblog[1];
		}
		rc.sum_column= not isnull(rc.count) ?ceiling(no/rc.limit):0 ;
		
		rc.listpostes = QueryExecute(
			"SELECT bp.*,us.userID, us.fullname, numofcomment, numofcategory, bcc.listcategorynames, bcc.listcategoryids 
			FROM blogpost bp LEFT JOIN (SELECT COUNT(commentID) AS numofcomment, blogpostID 
				FROM blogcomment GROUP BY blogpostID) bgc ON bgc.blogpostID = bp.blogpostID 
		INNER JOIN ( SELECT bc.blogpostID,bc.categoryID, 
		GROUP_CONCAT(c.categoryname SEPARATOR ',') AS listcategorynames,
		GROUP_CONCAT(c.categoryID SEPARATOR ',') AS listcategoryids, COUNT(c.categoryID) AS numofcategory 
			FROM category c inner join blogpost_category bc on bc.categoryID = c.categoryID 
			GROUP BY bc.blogpostID) bcc 
		ON bcc.blogpostID = bp.blogpostID, user us 
		WHERE bp.userID = us.userID"& conditionquery &" 
		ORDER BY bp.status , bp.updated desc, bp.created desc limit "& rc.idpage &","& rc.limit);
	}
	
	function login(struct rc) {
		if(CGI.REQUEST_METHOD == "post"){
			var theUser = entityLoad("user",{email:rc.emailuser, password:hash(rc.passworduser)},true);
			if(not isnull(theUser)){
				SESSION.bloggerName = theUser.fullname;
				SESSION.BloggerID = theUser.userID;
				SESSION.isLoggedIn = true;
				var messages = "Login success! Welcome";
				variables.fw.redirect("main.default",messages);
			}else{
				rc.messages = "Login failure! Please check your login account";
			}
		}
	}
	
	function logout(struct rc) {
		structClear(SESSION);
		SESSION.isLoggedIn = false;
		var messages = "Login success! Welcome";
		variables.fw.redirect("main.default",messages);
	}
	

	function register(struct rc) {
		if(CGI.REQUEST_METHOD EQ "POST")
		 	{
				rc.user = entityNew("user");
				rc.user.setEmail(rc.useremail);
				rc.user.setPassword(hash(rc.userpassword));
				rc.user.setFullname(rc.firstname & rc.lastname);
				rc.user.setImage("team-member-1.jpg");
				rc.user.setCreated(DateTimeFormat(Now(),"mmm d, yyyy HH:nn:ss"))
				entitySave(rc.user);
				variables.fw.redirect("main.login");
		 	}
	}


	function deletepost(struct rc) {
		rc.blogpost=entityloadbyPK("blogpost",rc.blogpostid);
		EntityDelete(rc.blogpost);
		variables.fw.renderData("json",{success:true});
	}
	
	

	function posting(struct rc) {
		param name="rc.listcategories" default=entityLoad("category");
		param name="URL.blogpostid" default="";
		if(not isNull(rc.blogpostid))
			 rc.blogpost = entityLoadByPK("blogpost",rc.blogpostid);
		if(CGI.REQUEST_METHOD == "post"){
			if(URL.blogpostid > 0){
				LOCAL.blogpost=entityLoadByPK("blogpost",rc.blogpostid);
				blogpost.setUpdated(DateTimeFormat(Now(),"mmm d, yyyy HH:nn:ss"));
				blogpost.setUpdatedby(SESSION.bloggerName);
				blogpost.setStatus(2);
			}				
			else{
				LOCAL.blogpost=entityNew("blogpost");
				blogpost.setCreated(DateTimeFormat(Now(),"mmm d, yyyy HH:nn:ss"));
				blogpost.setStatus(3);
			}
			var arraylistcategorypostes = arrayNew(1);
			var category = entityNew("category");
			for(var i=1; i <= arrayLen(rc.listcategoryids); i++) {
				category = entityLoadByPK("category", rc.listcategoryids[i]);			
				arrayAppend(arraylistcategorypostes, category);
			}


			blogpost.setCategories(arraylistcategorypostes);
			blogpost.setTitle(rc.title);
			blogpost.setSubtitle(rc.subtitle);
			blogpost.setContext(rc.context);
			blogpost.setDescription(rc.description);
			blogpost.setUserID(entityLoadByPK("user",SESSION.BloggerID));
			entitySave(blogpost);
			var blogpostid = blogpost.blogpostID;
			variables.fw.redirect(action="main.displayblogpost", queryString="blogpostid=#blogpostid#");
		}
	}

	function loadPost(required string blogpostid) {
		return rc.blogposted = QueryExecute(
			"SELECT bp.*,us.fullname,us.image, numofcomment, numofcategory, bcc.listcategorynames, bcc.listcategoryids 
			FROM blogpost bp LEFT JOIN (SELECT COUNT(commentID) AS numofcomment, blogpostID 
				FROM blogcomment GROUP BY blogpostID) bgc ON bgc.blogpostID = bp.blogpostID 
		INNER JOIN ( SELECT bc.blogpostID,GROUP_CONCAT(c.categoryname SEPARATOR ',') AS listcategorynames, 
			GROUP_CONCAT(c.categoryID SEPARATOR ',') AS listcategoryids, COUNT(c.categoryID) AS numofcategory 
			FROM category c INNER JOIN blogpost_category bc ON bc.categoryID = c.categoryID 
			GROUP BY bc.blogpostID)bcc ON bcc.blogpostID = bp.blogpostID, user us 
		WHERE bp.userID = us.userID and bp.blogpostID = "&LSParseNumber(blogpostid));
	}


	function loadCommentofPost(required string blogpostid) {
		return rc.listcommentes = QueryExecute("select * from blogcomment WHERE blogpostID="&LSParseNumber(blogpostid));
	}
	

	function displayblogpost(struct rc) {
		if(CGI.REQUEST_METHOD == "post"){
			var blogpost = entityLoadByPK("blogpost",rc.blogpostid);
			blogcomment=entityNew("blogcomment");
			blogcomment.setUsername(rc.name);
			blogcomment.setEmail(rc.email);
			blogcomment.setContext(rc.context);
			blogcomment.setCreated(DateTimeFormat(Now(),"mmm d, yyyy HH:nn:ss"));
			blogpost.addBlogcomment(blogcomment);			
			entitySave(blogcomment);
			var blogpostid = blogpost.blogpostID;
			variables.fw.redirect(action="main.displayblogpost", queryString="blogpostid=#blogpostid#");
		}
		rc.blogposted = loadPost(rc.blogpostid);
		if(rc.blogposted.numofcomment > 0)
			rc.listcommentes = loadCommentofPost(rc.blogpostid);
	}


	function shortinfo(struct rc) {
	}
	
	
	function search(struct rc) {
		if(CGI.REQUEST_METHOD == "post"){
			VARIABLES.fw.Redirect("main.default?keysearch=#rc.conditionsearch#");
		}
	}

}