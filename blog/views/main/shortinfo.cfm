<cfoutput>
    <cfset userinfo = QueryExecute("select us.userID, image, fullname, count(blogpostID) numofpostes from user us, blogpost bp WHERE us.userID = #LSParseNumber(SESSION.BloggerID)# and us.userID=bp.userID")>

    <div class="row">
        <div class="author">
            <div class="testimonial-image ">
                <img alt="" src="/asset/img/#userinfo.image#">
            </div>
            <div class="testimonial-author-info">
                <a href="/index.cfm/?userid=#userinfo.userID#"><span class="color">#userinfo.fullname#</span></a>
            </div>
        </div>
        <!--- <div class="blog-entry-meta-comments">
            <i class="fa fa-comments"></i>
            <a href="" class="blog-entry-meta-comments">4 com</a>
        </div> --->
        <cfif userinfo.numofpostes gt 0>
            <div class="blog-entry-meta-author">
                <i class="fa fa-user"></i>
                <a href="/index.cfm/?userid=#userinfo.userID#" class="blog-entry-meta-author"> #userinfo.numofpostes# <cfif userinfo.numofpostes eq 1>post<cfelse>posts</cfif></a>
            </div>
        </cfif>
        <div class="blog-divider"></div>
    </div>
    
</cfoutput>