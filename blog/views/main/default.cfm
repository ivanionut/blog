
<cfset listpostes = rc.listpostes>
<cfoutput>
	<script type="text/javascript">
	//check paging
	function checkPrev(){
    	var search= window.location.search;
    	var temp=search.split("page=");
    	var result= temp[1];
    	return result>1;
    }
    function checkNext(totalPage){
    	var search= window.location.search;
    	var temp=search.split("page=");
    	var result= temp[1];
    	if(result==0)
    		return result>1;
    	return result<totalPage;
    }
</script>
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
	<ul class="pager">
	            <li class="previous">
	            	<a href="#rc.main_page#?page=#URL.page-1#" onclick="return checkPrev()">&larr; Older</a>
	        	</li>
	            <cfloop from="1" to="#rc.sum_column#" index="i">			
					<cfif i eq URL.page>
						<li class="active">
							<a href="#rc.main_page#?page=#i#">#i#</a>
						</li>
					<cfelse>
					<li class="disabled">
						<a href="#rc.main_page#?page=#i#">#i#</a>
					</li>
					</cfif>
				</cfloop>
	            <li class="next">
	            	<a href="#rc.main_page#?page=#URL.page+1#" onclick="return checkNext(#rc.sum_column#)">Newer &rarr;</a>
	            </li>
    </ul>
</cfoutput>
