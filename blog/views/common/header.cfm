<cfset catelist = QueryExecute("select categoryID,categoryname from category")>
<cfoutput>
  <header id="section1">
    	<div id="navigation">
          <nav class="navbar navbar-custom cl-effect-21" role="navigation">
            	<div class="container">
                  <div class="row">
                    	<div class="col-md-2 mob-logo">
                          <div class="row">
                            	<div class="site-logo">
                                  <a href="/index.cfm">Blog Rasia</a>
                            	</div>
                          </div>
                    	</div>

                      <div class="col-md-10 mob-menu">
                          <div class="row">                                          
                            	<div class="navbar-header">
                                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##menu">
                                  <i class="fa fa-bars"></i>
                                  </button>
                            	</div>                             
                            	<div class="collapse navbar-collapse" id="menu">
                                  <ul class="nav navbar-nav navbar-left">
                                    <cfloop query="catelist">
                                      <li>
                                        <a class="external" href="/index.cfm/?categoryid=#categoryID#">#categoryname#</a>
                                      </li>
                                    </cfloop>
                                  </ul>

                                  <ul class="nav navbar-nav navbar-right">
                                    <cfif SESSION.isLoggedIn eq true>
                                      <li>                                        
                                          <a class="external" href="/index.cfm/main.logout">Logout</a>
                                      </li>
                                      <li>
                                        <a class="external" href="/index.cfm/main.posting">Post</a>
                                      </li>
                                    <cfelse>
                                      <li>
                                        <a class="external" href="/index.cfm/main.login">Login</a>
                                      <li>
                                        <a class="external" href="/index.cfm/main.register">Register</a>
                                      </li>
                                    </cfif>
                                  </ul>
                            	</div>
                          </div>
                      </div>
                  </div>
            	</div>
          </nav>
    	</div>                          
  </header>
</cfoutput>