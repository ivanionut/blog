<cfoutput>
    <div class="posts-block col-lg-9 col-md-9 col-sm-8 col-xs-12 bottom-pad">
        <cfset blogposted = rc.blogposted>
        <!--- <cfdump eval=blogposted>
        <cfabort> --->
        <cfset arraycategorynames = ListToArray(blogposted.listcategorynames)>
        <cfset arraycategoryids = ListToArray(blogposted.listcategoryids)>
         
        <article class="post hentry">
            <header class="post-header">
                <h3 class="content-title"><a href="/index.cfm/?blogpostid=#blogposted.blogpostID#">#blogposted.title#</a></h3>
                <div class="blog-entry-meta">
                    <div class="blog-entry-meta-date">
                        <i class="fa fa-clock-o"></i>
                        <span class="blog-entry-meta-date-month">#MonthAsString(Month(blogposted.created))# , #Day(blogposted.created)# #Year(blogposted.created)#</span>
                        <span class="blog-entry-meta-date-day"> #TimeFormat(blogposted.created, "HH:mm:ss tt")#</span>
                    </div>
                    <div class="blog-entry-meta-author">
                        <i class="fa fa-user"></i>
                        <a href="/index.cfm/?userid=#blogposted.userID#" class="blog-entry-meta-author">#blogposted.fullname#</a>
                    </div>
                    <div class="blog-entry-meta-tags">
                        <i class="fa fa-tags"></i>
                        <cfloop index="i" from="1" to="#blogposted.numofcategory#">
                            <a href="/index.cfm/?categoryid=#arraycategoryids[i]#">#arraycategorynames[i]#</a><cfif (i lt (blogposted.numofcategory))>, </cfif>
                        </cfloop>
                    </div>            
                </div>
            </header>
            <div class="post-content">
                <code> #blogposted.context#</code>
                <cfif TimeFormat(blogposted.updated,"HH:mm:ss tt") gt 0>
                    The last updated is #MonthAsString(Month(blogposted.updated))# , #Day(blogposted.updated)# #Year(blogposted.updated)# - #TimeFormat(blogposted.updated, "HH:mm:ss tt")# by <a href="/index.cfm/?userid=#blogposted.blogpostID#" class="blog-entry-meta-author">#blogposted.updatedby#</a>
                </cfif>
            </div>
            <footer class="post-footer">
                <div class="blog-divider"></div>
                <cfif StructKeyExists(SESSION,"BloggerID") and SESSION.BloggerID eq blogposted.userID>    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" ><a href="" class="btn btn-2 btn-2c" onclick="return checkDelete()">Delete</a></div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" ><a href="/index.cfm/main.posting/?blogpostid=#blogposted.blogpostID#" class="btn btn-2 btn-2c">Edit</a></div>
                    </div>                                       
                </cfif>
            </footer>
        </article>
        <div class="blog-divider"></div>

        <cfif SESSION.isLoggedIn eq false or (StructKeyExists(SESSION,"BloggerID") and SESSION.BloggerID neq blogposted.userID)>
            <div class="about-author">
                <h3 class="title">About The Author</h3>
                <div class="author-content">
                    <div class="avatar"><img alt="" src="/asset/img/#blogposted.image#"></div>
                    <div class="data">
                        <h4><a href="/index.cfm/?userid=#blogposted.userID#">#blogposted.fullname#</a></h4>
                        <p>
                          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
                        </p>
                    </div>
                </div>
            </div>

            <div class="blog-divider"></div> 
        </cfif>

        <cfif blogposted.numofcomment gt 0 >
            <cfset listcommentes = rc.listcommentes>
            <div class="comment-wrapper">
                <h3 class="title">Comments</h3>
                <div class="clearfix"></div>
                <div class="comments-sec">
                    <ol class="commentlist">
                        <cfloop query="listcommentes">
                            <li>
                                <div class="comment">
                                    <div class="avatar">
                                        <img alt="" src="/asset/img/team-member-1.jpg">
                                    </div>
                                    <div class="comment-des">
                                        <div class="arrow-comment"></div>
                                        <div class="comment-by">
                                            <strong>#listcommentes.username#</strong><span class="date">#MonthAsString(Month(listcommentes.created))# , #Day(listcommentes.created)# #Year(listcommentes.created)#</span>
                                        </div>
                                        <p>
                                          #listcommentes.context#
                                        </p>
                                    </div>

                                    <div class="clearfix"></div>
                                </div>
                                <div class="clearfix"></div>
                            </li> 
                        </cfloop>                        
                    </ol>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="blog-divider"></div>            
        </cfif>

        <div class="reply">
            <h3 class="title">Leave a reply</h3>
            <form class="reply" name="reply" action="/index.cfm/main.displayblogpost/?blogpostid=#blogposted.blogpostid#" method="post" id="reply">
                <fieldset>
                    <div class="row">
                         <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <cfif not isNull(SESSION.BloggerID)>
                                <label>Name:</label>
                                <input class="form-control" type="text" id="txtNameComment" name="name" value="#blogposted.fullname#">
                            <cfelse>    
                                <label>Name: <span>*</span></label>
                                <input class="form-control" type="text" id="txtNameComment" name="name" required>
                            </cfif>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <cfif not isNull(SESSION.BloggerID)>
                                <cfdump eval= SESSION.BloggerID>
                                <cfabort>
                                <label>Email:</label>
                                <input class="form-control" type="email" id="txtEmailComment" name="email" value="#blogposted.email#">
                            <cfelse>    
                                <label>Email: <span>*</span></label>
                                <input class="form-control" type="email" id="txtEmailComment" name="email" required>
                            </cfif>
                            <!--- <label>Email: <span>*</span></label>
                            <input class="form-control" type="email" id="txtEmailComment" name="email" required> --->
                        </div>

                        <!--- <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <label>Name: <span>*</span></label>
                            <input class="form-control" type="text" id="txtNameComment" name="name" required>
                        </div> --->
                        <!--- <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <label>Email: <span>*</span></label>
                            <input class="form-control" type="email" id="txtEmailComment" name="email" required>
                        </div> --->
                    </div>

                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <label>Comment: <span>*</span></label>
                            <textarea class="form-control" rows="3" cols="40" id="txtContentComment" name="context" required></textarea>
                        </div>
                    </div>
                </fieldset>

                <button class="btn btn-2 btn-2c" type="submit">Post Reply</button>
                
                <div class="clearfix"></div>
            </form>
        </div>                                         
    </div> 
    <script type="text/javascript">
        function checkDelete() {
            if(confirm("Are you sure you want delete it?")){
                $.ajax({
                    url: "/index.cfm/main.deletepost",
                    method:'POST',
                    data: {blogpostid:#blogposted.blogpostID#},
                    dataType: 'json',
                    success: function (data) {
                        if (data.success){
                            alert("success");
                            window.location="/blog/views/main/index.cfm";
                        }
                    }
                });
            }
        }
    </script>
</cfoutput>