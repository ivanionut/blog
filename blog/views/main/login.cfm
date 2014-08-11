<cfoutput>
    <cfif not isNull(rc.messages)>
        <div class="row">
            <div class="col-md-12">#rc.messages#</div>
        </div>
    </cfif>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-2 bgform">
                <form id="validaLogin" method="post" action="/index.cfm/main.login" class="reply" autocomplete="on">
                    <fieldset class="loginform">
                    	<legend class="loginform"><h3>Login</h3></legend>
                      	<div class="row">                                          
                            <div class="col-md-12">
                                <div class="form-group form-group-lg has-feedback">                   
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class=" fa fa-envelope-o fa-fw"></span></span>
                                        <input class="form-control" type="email" name="emailuser" id="emailuser" placeholder="Email">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group form-group-lg has-feedback">
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class=" fa fa-key fa-fw"></span></span>
                                        <input class="form-control" type="password" name="passworduser" id="passworduser" placeholder="Password">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-5 col-md-offset-7">
                                    <button type="submit" class="btn btn-2 btn-2c">Login</button>
                                </div>
                            </div>                                      
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</cfoutput>

<script>
    $(document).ready(function() {
        $('#validaLogin')
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
                emailuser: {
                    validators: {
                        notEmpty: {
                            message: 'The email address is required and cannot be empty'
                        },
                        emailAddress: {
                            message: 'The value is not a valid email address'
                        }
                    }
                },
                passworduser: {
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
                        }
                    }
                }
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
    })
</script>

