<cfoutput>
    <cfset LOCAL.listcategories = rc.listcategories>
    <cfif isNull(rc.blogpost)> 
        <cfset blogpost.title = "Blog post title">
        <cfset blogpost.context = "Context of post">
        <cfset blogpost.listcategoryids = arrayNew(1)>
        <cfset blogpost.description = "Context of post">
    <cfelse>
        <cfset blogpost.blogpostid = rc.blogpost.blogpostID>
        <cfset blogpost.title = rc.blogpost.title>
        <cfset blogpost.context = rc.blogpost.context>
        <cfset blogpost.listcategoryids = rc.blogpost.categories>
        <cfset blogpost.description = rc.blogpost.description>
    </cfif>
    <div class="reply">
        <h3 class="title">Blog Post</h3>
        <form class="reply" id="reply" method="post" onsubmit="createDescription();">
            <fieldset>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <div class="form-group has-feedback">
                            <label>Blog post title: <span>*</span></label>
                            <input class="form-control" name="title" type="text" required <cfif not isNull(rc.blogpost)>value="#blogpost.title#"<cfelse>placeholder="#blogpost.title#"</cfif>/>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <div class="form-group has-feedback">
                            <label>Category: <span>*</span></label>
                            <select class="form-control multiselect" id="listcategoryids" name="listcategoryids[]" multiple="multiple">
                                <cfloop array=#listcategories# index="cate">
                                    <option value=#cate.categoryID#
                                    <cfloop array=#blogpost.listcategoryids# index="i">
                                        <cfif cate.categoryID eq i.categoryID>selected</cfif>
                                    </cfloop>   
                                    >#cate.categoryname#</option>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group has-feedback">
                            <label>Sub title:<span></span></label>
                            <input class="form-control" name="subtitle" type="text" id="subtitle" name="subtitle"></input>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group has-feedback">
                            <label>Context: <span>*</span></label>
                            <textarea class="ckeditor" rows="5" cols="40" id="context" name="context" required>#blogpost.context#</textarea>
                        </div>
                    </div>
                </div>
                <cfif not isNull(rc.blogpost)>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="form-group has-feedback">
                                <label>Do you want to say something about updated post? <span></span></label>
                                <input class="form-control" type="text" name="updatetext" id="updatetext" name="updatetext"></textarea>
                            </div>
                        </div>
                    </div>
                </cfif>

                <input type="hidden" name="description" id="description" value="#blogpost.context#" />

            </fieldset>

            <button class="btn btn-2 btn-2c" type="submit">Post</button>
              
            <div class="clearfix"></div>
        </form>
    </div>    
    <div class="blog-divider"></div>
</cfoutput>

<script type="text/javascript">
function createDescription() {
    //example as before, replace YOUR_TEXTAREA_ID
    var html=CKEDITOR.instances.context.getSnapshot();
    var dom=document.createElement("DIV");
    dom.innerHTML=html;
    var plain_text=(dom.textContent || dom.innerText);

    var des=plain_text.substr(0,300);
    document.getElementById("description").value=des.concat(" ...");

    //return true, ok to submit the form
    return true;
}
</script>

<script>
    $(document).ready( function() {
        CKEDITOR.replace('context',{allowedContent: true});
    
        $('#listcategoryids').multiselect({
            includeSelectAllOption: true,
            buttonClass: 'btn-primary btn-lg',
            buttonWidth: 'auto',
            numberDisplayed: 2,
            buttonText: function(options) {
                if (options.length == 0) {
                    return 'Select categories <b class="caret"></b>';
                }
                else if (options.length > 6) {
                    return options.length + ' selected  <b class="caret"></b>';
                }
                else {
                    var selected = '';
                    options.each(function() {
                        selected += $(this).text() + ', ';
                    });
                    return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
                }
            },
            onChange: function(option, checked) {
                var selected = 0;
                $('option', $('#listcategoryids')).each(function() {
                    if ($(this).prop('selected')) {
                        selected++;
                    }
                });
         
                if (selected == 0) {
                    if(confirm('Do you wish to deselect all the categories? Post of category must be selected less one! And the default selected category will choice.')){
                        $("#listcategoryids").multiselect('select', $("#listcategoryids option:first").val());
                        $('#listcategoryids').siblings('div').children('ul').dropdown('toggle');
                    }
                }
            },
        });
    })
</script>

