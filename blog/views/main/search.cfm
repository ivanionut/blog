
<script>
	function onClick()
	{
	    var valueSearch = document.getElementById('keysearch');
	    alert(valueSearch.value);
	    window.location="/index.cfm?keysearch=" + valueSearch.value;
	}
</script>

<div class="widget search-form">
	<!--- <form method="post" action="/index.cfm/main.search" class="reply" autocomplete="on"> --->
		<div class="input-group">
	        <input type="text" value="Search..." onfocus="if(this.value=='Search...')this.value='';" onblur="if(this.value=='')this.value='Search...';" class="search-input form-control" name="conditionsearch" id="keysearch">
	        <span class="input-group-btn">
	        	<button class="subscribe-btn btn" onclick="onClick()"><i class="fa fa-search"></i></button>
	        </span>
	    </div>  
	<!--- </form>                                   --->
</div>