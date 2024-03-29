<cfset listpostes = rc.listpostes>
<cfoutput>
	<script type="text/javascript">
	//check paging
	function checkPrev(){
     var search= window.location.search;
     var temp=search.split("page=");
     
     if(temp.length > 1)
     {
      var temp2=temp[1].split("&");
      if(temp2.length > 1)
      {
       var result= temp2[0];
       return result>1;
      }else
      {
    var result= temp[1];
    return result>1;
      }
     }else
     {
      return false
     } 
    }

    function checkNext(totalPage){
    	var search= window.location.search;
    	var temp=search.split("page=");
    	var temp2=temp[1].split("&");
    	var result= temp2[0];
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
	                        <a href="/index.cfm/?categoryid=#arraycategoryids[i]#">
	                        	#arraycategorynames[i]#</a>
	                        <cfif (i lt (numofcategory))>, </cfif>
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
	        <div class="post-content" >
	            #listpostes.description#
	            <div class="read">
	            	<a class="moreLink" href="/index.cfm/main.displayblogpost/?blogpostid=#listpostes.blogpostid#">
	            		</br>Read&nbsp;more&nbsp;&rsaquo;&rsaquo;
	            	<i class="icon-caret-right"></i>
	            	</a>
	            </div>
	           
	        </div>
	    </article>
	    <div class="blog-divider"></div>
	</cfloop>
	<ul class="pager">
	            <li class="previous">


	            	<cfif not isNull(rc.userid)>
						<a href="#rc.main_page#?page=#URL.page-1#&userid=#rc.userid#"  onclick="return checkPrev()">&larr; Newer</a>
						<cfelseif not isNull(rc.categoryid)>
						    <a href="#rc.main_page#?page=#URL.page-1#&categoryid=#rc.categoryid#"  onclick="return checkPrev()">&larr; Newer</a>
						    <cfelse>
						    	<a href="#rc.main_page#?page=#URL.page-1#" onclick="return checkPrev()">&larr; Newer</a>
					</cfif>


	            	<!--- <cfif not isNull(rc.categoryid)>
						<a href="#rc.main_page#?page=#URL.page-1#&categoryid=#rc.categoryid#" onclick="return checkPrev()">&larr; Newer</a>
					<cfelse>
						<a href="#rc.main_page#?page=#URL.page-1#" onclick="return checkPrev()">&larr; Newer</a>
					</cfif> --->
	        	</li>
	            <cfloop from="1" to="#rc.sum_column#" index="i">			
					<cfif i eq URL.page>
						<li class="active">
							<cfif not isNull(rc.userid)>
						        <a href="#rc.main_page#?page=#i#&userid=#rc.userid#">#i#</a>
						    <cfelseif not isNull(rc.categoryid)>
						    	 <a href="#rc.main_page#?page=#i#&categoryid=#rc.categoryid#">#i#</a>
						    	 <cfelse>
						    	 	 <a href="#rc.main_page#?page=#i#">#i#</a>
						    </cfif>
						</li>
					<cfelse>
					<li class="disabled">
						<cfif not isNull(rc.userid)>
						        <a href="#rc.main_page#?page=#i#&userid=#rc.userid#">#i#</a>
						    <cfelseif not isNull(rc.categoryid)>
						    	 <a href="#rc.main_page#?page=#i#&categoryid=#rc.categoryid#">#i#</a>
						    	 <cfelse>
						    	 	 <a href="#rc.main_page#?page=#i#">#i#</a>
						    </cfif>
					</li>
					</cfif>
				</cfloop>
	            <li class="next">

	            	<cfif not isNull(rc.categoryid)>
						<a href="#rc.main_page#?page=#URL.page+1#&categoryid=#rc.categoryid#" onclick="return checkNext(#rc.sum_column#)">Older &rarr;</a>
					<cfelse>
						<a href="#rc.main_page#?page=#URL.page+1#" onclick="return checkNext(#rc.sum_column#)">Older &rarr;</a>
					</cfif>
	            </li>
    </ul>
</cfoutput>
