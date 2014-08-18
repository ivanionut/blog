<!--- 		<ul class="pager">
            <li class="previous"><a href="/index.cfm/blogger.display/?postid=#blogPost.postid - 1#">&larr; Older</a></li>
            <li class="next"><a href="/index.cfm/blogger.display/?postid=#blogPost.postid + 1#">Newer &rarr;</a></li>
        </ul>
        <div class="blog-divider"></div> --->

<cfoutput>
    <cfif arrayLen(commentslist) gt 0 >
        <div class="comment-wrapper">
            <h3 class="title">Comments</h3>
            <div class="clearfix"></div>
            <div class="comments-sec">
                <ol class="commentlist">
                    <cfloop array="commentslist" index="comment">
                        <li>
                            <div class="comment">
                                <div class="avatar">
                                    <img alt="" src="asset/img/team-member-1.jpg">
                                </div>
                                <div class="comment-des">
                                    <div class="arrow-comment"></div>
                                    <div class="comment-by">
                                        <strong>#comment.getName()#</strong><span class="date">#MonthAsString(Month(comment.getCreated()))# , #Day(comment.getCreated())# #Year(comment.getCreated())#</span>
                                    </div>
                                    <p>
                                      #comment.getContext()#
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
        <form class="reply" name="reply" action="/index.cfm/?blogpostid=#blogpost.blogpostid#" method="post" id="reply">
            <fieldset>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <label>Name: <span>*</span></label>
                        <input class="form-control" type="text" id="name" name="name" required>
                        
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <label>Email: <span>*</span></label>
                        <input class="form-control" type="email" id="email" name="email" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <label>Comment: <span>*</span></label>
                        <textarea class="form-control" rows="3" cols="40" id="content" name="content" required></textarea>
                    </div>
                </div>
            </fieldset>

            <button class="btn btn-2 btn-2c" type="submit">Post Reply</button>
            
            <div class="clearfix"></div>
        </form>
    </div>
</cfoutput>