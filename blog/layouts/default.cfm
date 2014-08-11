<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Blog Rasia</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">

		<link rel="stylesheet" href="/plugin/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/plugin/bootstrap/css/bootstrap-theme.min.css">
		<link rel="stylesheet" href="/plugin/bootstrap/css/bootstrap-multiselect.css">
		<link rel="stylesheet" href="/plugin/bootstrapvalidator/css/bootstrapValidator.min.css">
		<link rel="stylesheet" href="/plugin/FontAwesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="/asset/css/animations.css">
		<link rel="stylesheet" href="/asset/css/hover.css">
		<link rel="stylesheet" href="/asset/css/style.css">
		<link rel="stylesheet" href="/asset/css/blog.css">
		<link rel="stylesheet" href="/asset/css/colors/blue.css">
		
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>
      	<link href='http://fonts.googleapis.com/css?family=Raleway:400,500,600,700' rel='stylesheet' type='text/css'>
      	<link href='http://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'> 
      	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine" />

		<script src="/plugin/bootstrap/js/jquery.min.js"></script>
		<script src="/plugin/ckeditor/ckeditor.js"></script>		

		<script src="/plugin/bootstrap/js/bootstrap.min.js"></script>
		<script src="/plugin/bootstrap/js/bootstrap-multiselect.js"></script>
		<script src="/plugin/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
		<script src="/asset/js/jquery.scrollTo.min.js"></script>
		<script src="/asset/js/jquery-ui.js"></script>
		<script src="/asset/js/jquery.nav.js"></script>
		<script src="/asset/js/skrollr.min.js"></script>
		<script src="/asset/js/jquery.sticky.js"></script>
		<script src="/asset/js/jquery.isotope.js"></script>
		<script src="/asset/js/jquery.wait.js"></script>
		<script src="/asset/js/wow.js"></script>
		<script src="/asset/js/custom.js"></script>
	</head>
	<body>
		<div>
			<cfoutput>
				#view("common/header")#			
		        <section id="section3" class="blog">              
		            <div class="content">
		                <div class="container">                      
		                    <div class="row">
		                    	<div class="posts-block col-lg-9 col-md-9 col-sm-9 col-xs-12">
		                    	#body#
		                    	</div>
		                    	<div class="sidebar col-lg-3 col-md-3 col-sm-4 col-xs-12">
		                    		<cfif SESSION.isLoggedIn eq true>
		                    			#view("main/shortinfo")#
		                    		</cfif>		                    		
		                    		#view("main/search")#
		                    		<!--- #view("common/widget")# --->
								</div>                          
		                    </div>
		                </div>
		            </div>                  
		        </section>
		        #view("common/footer")#
	        </cfoutput>
	    </div>
	</body>
</html>	            
	            
	         