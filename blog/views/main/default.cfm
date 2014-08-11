<cfset listpostes = rc.listpostes>
<cfoutput>
	<cfloop query="listpostes">
		<cfset arraycategorynames = ListToArray(listcategorynames)>
		<cfset arraycategoryids = ListToArray(listcategoryids)>
	    <article class="post hentry">
	        <header class="post-header">
	            <h3 class="content-title"><a href="/index.cfm/main.displayblogpost/?blogpostid=#listpostes.blogpostid#">#listpostes.title#</a></h3>
	            <div class="blog-entry-meta">
	            	<div class="blog-entry-meta-date">
	                    <i class="fa fa-clock-o"></i>
	                    <span class="blog-entry-meta-date-month">#MonthAsString(Month(listpostes.created))# , #Day(listpostes.created)# #Year(listpostes.created)#</span>
	                    <span class="blog-entry-meta-date-day"> #TimeFormat(listpostes.created, "HH:mm:ss tt")#</span>
	                </div>
	                <div class="blog-entry-meta-author">
	                    <i class="fa fa-user"></i>
	                    <a href="/index.cfm/?userId=#listpostes.userid#" class="blog-entry-meta-author">#listpostes.fullname#</a>
	                </div>
	                <div class="blog-entry-meta-tags">
	                    <i class="fa fa-tags"></i>
	                    <cfloop index="i" from="1" to="#numofcategory#">
	                        <a href="/index.cfm/?categoryid=#arraycategoryids[i]#">#arraycategorynames[i]#</a><cfif (i lt (numofcategory))>, </cfif>
	                    </cfloop>
	                </div>
	                <cfif listpostes.numofcomment gt 0>
	                    <div class="blog-entry-meta-comments">
	                        <i class="fa fa-comments"></i>
	                        <a href="/index.cfm/main.displayblogpost/?blogpostid=#listpostes.blogpostid#" class="blog-entry-meta-comments">#listpostes.numofcomment# comments</a>
	                    </div>
	                </cfif>                
	            </div>
	        </header>
	        <div class="post-content">
	           <code> #listpostes.context#</code>
	        </div>
	    </article>
	    <div class="blog-divider"></div>
	</cfloop>
</cfoutput>
