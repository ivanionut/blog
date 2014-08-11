<div class="container">
	<div class="row">
		<div class="col-md-6 col-md-offset-2 bgform">
			<form id="validaResgister" method="post" action="/index.cfm/main.register" autocomplete="on">
				<fieldset class="loginform">
					<legend class="loginform"><h3>Register</h3></legend>
					<div class="form-group form-group-lg has-feedback">
						<label class="control-label" for="useremail">Email</label>
					    <div class="input-group">
				    		<span class="input-group-addon"><span class=" fa fa-envelope-o fa-fw"></span></span>
				      		<input class="form-control" type="email" name="useremail" id="useremail" placeholder="Email">
				    	</div>						   
					</div>
					<div class="form-group form-group-lg has-feedback">
						<label class="control-label" for="userpassword">Password</label>
				       	<div class="input-group">
				    		<span class="input-group-addon"><span class=" fa fa-key fa-fw"></span></span>
				      		<input class="form-control" type="password" name="userpassword" id="userpassword" placeholder="Password">
				    	</div>							    	
					</div>
					<div class="form-group form-group-lg has-feedback">
						<label class="control-label" for="ConfirmPassword">Please confirm your password</label>
					    <div class="input-group">
				    		<span class="input-group-addon"><span class="fa fa-key fa-fw"></span></span>
				      		<input class="form-control" type="password" name="ConfirmPassword" id="ConfirmPassword" placeholder="Please confirm your password">
					    </div>
					</div>
					<div class="form-group form-group-lg has-feedback">
						<div class="row">
							<div class="col-sm-6">
								<label class="control-label" for="firstname">First name</label>
						    	<div class="input-group">
						    		<span class="input-group-addon"><span class=" fa fa-user fa-fw"></span></span>
						      		<input class="form-control" type="text" name="firstname" id="firstname" placeholder="First Name">
						    	</div>						    	
						    </div>							
						    <div class="col-sm-6">
						    	<label class="control-label" for="lastname">Last name</label>
						    	<div class="input-group">
						    		<span class="input-group-addon"><span class=" fa fa-user fa-fw"></span></span>
						      		<input class="form-control" type="text" name="lastname" id="lastname" placeholder="Last Name">
						    	</div>						    	
						    </div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-offset-6 col-sm-6">
						      	<button type="submit" class="btn btn-2 btn-2c">Register</button>
						    </div>
						</div>							    
					</div>
				</fieldset>        
			</form>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
    	$('#validaResgister')
			.on('init.field.bv', function(e, data) {
            var $parent    = data.element.parents('.form-group'),
                $icon      = $parent.find('.form-control-feedback[data-bv-icon-for="' + data.field + '"]'),
                options    = data.bv.getOptions(),                     
                validators = data.bv.getOptions(data.field).validators; 
            if (validators.notEmpty && options.feedbackIcons && options.feedbackIcons.required) {
               $icon.addClass(options.feedbackIcons.required).hide();
            }
        })
		.bootstrapValidator({
	        feedbackIcons: {
	            required: 'fa fa-asterisk',
	            valid: 'fa fa-check',
	            invalid: 'fa fa-times',
	            validating: 'fa fa-refresh'
	        },
	        fields: {
	        	firstname: {
	        		group: '.col-sm-6',
	        		validators: {
	        			notEmpty: {
	        				message: 'The first name is required and cannot be empty'
	        			}
	        		}
	        	},
	        	lastname: {
	        		group: '.col-sm-6',
	        		validators: {
	        			notEmpty: {
	        				message: 'The last name is required and cannot be empty'
	        			}
	        		}
	        	},
                useremail: {
                    validators: {
                        notEmpty: {
                            message: 'The email address is required and cannot be empty'
                        },
                        emailAddress: {
                        	message: 'The value is not a valid email address'
                        },
                        different: {
	                        field: 'userpassword',
	                        message: 'The email and password cannot be the same as each other'
	                    }
                    }
                },
                userpassword: {
                	validators: {
                		notEmpty: {
                			message: 'The password is required and cannot be empty'
                		},
                		stringCase: {
                			message: 'The password must be in lowercase',
                			'case': 'lower'
                		},
                		stringLength: {
                			min: 6,
                			max: 20,
                			message: 'Please enter the password between %s and %s characters long'
                		},
                		different: {
	                        field: 'useremail',
	                        message: 'The password cannot be the same as email.'
	                    },
	                    identical: {
	                        field: 'ConfirmPassword',
	                        message: 'The password and its confirm are not the same.'
	                    }
                	}
                },
                ConfirmPassword: {
                	validators: {
                		notEmpty: {
                			message: 'Please enter confirm your password.'
                		},
                		stringCase: {
                			message: 'The password must be in lowercase.',
                			'case': 'lower'
                		},
                		stringLength: {
                			min: 6,
                			max: 20,
                			message: 'Please enter the password between %s and %s characters long.'
                		},
                		identical: {
	                        field: 'userpassword',
	                        message: 'The password and its confirm are not the same.'
	                    }
                	}
                },
            }
        })
		.on('status.field.bv', function(e, data) {           
	        var $parent    = data.element.parents('.form-group'),
                $icon      = $parent.find('.form-control-feedback[data-bv-icon-for="' + data.field + '"]'),
                options    = data.bv.getOptions(),                      
                validators = data.bv.getOptions(data.field).validators; 
            if (validators.notEmpty && options.feedbackIcons && options.feedbackIcons.required) {
                $icon.removeClass(options.feedbackIcons.required).addClass('fa');
            }	            
        })
        .on('error.validator.bv', function(e, data) {
            data.element
                .data('bv.messages')
                .filter('[data-bv-validator="' + data.validator + '"]').show();
        });
	});
</script>
