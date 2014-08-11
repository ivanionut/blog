jQuery(document).ready(function () {

    
    jQuery.waitForImages.hasImgProperties = ['background','backgroundImage'];
    jQuery('body').waitForImages(function() {
        jQuery(".page-mask").delay(1200).fadeOut('slow');
        jQuery('body').css('overflowY','auto');
    });


/*-------------------------------------------------*/
/* =  Animated content
/*-------------------------------------------------*/

    wow = new WOW(
        {
            animateClass: 'animated',
            offset:       100
        }
    );

    wow.init();

/*==========================*/
/* Sticky Navigation
/*==========================*/
     
    jQuery("#navigation").sticky({topSpacing:0});

    
/*==========================*/
/* Navigation Scrolling
/*==========================*/
    jQuery('.nav').onePageNav({
            filter: ':not(.external)',
            begin: function() {
            console.log("start")
            },
            end: function() {
            console.log("stop")
            }
        });


    var navigationHeight = jQuery("#navigation").outerHeight();

    jQuery('.align-center a, .caption-inside a, .top-logo a, .video-section a').click(function(){
        jQuery('html, body').animate({
            scrollTop: jQuery( $.attr(this, 'href') ).offset().top - navigationHeight + 44
        }, 800, 'easeInQuad');
        
        /* Fix jumping of navigation. */
        setTimeout(function() {
            jQuery(window).trigger('scroll');
        }, 900);
        
        return false;
    });

/*----------------------------------------------------*/
/*  Scroll To Top Section
/*----------------------------------------------------*/
    jQuery(document).ready(function () {
    
        jQuery(window).scroll(function () {
            if (jQuery(this).scrollTop() > 100) {
                jQuery('.scrollup').fadeIn();
            } else {
                jQuery('.scrollup').fadeOut();
            }
        });
    
        jQuery('.scrollup').click(function () {
            jQuery("html, body").animate({
                scrollTop: 0
            }, 600);
            return false;
        });
    
    });


/*----------------------------------------------------*/
/*  Carousel Section
/*----------------------------------------------------*/

    
    jQuery('.testimonials-carousel').carousel({interval: false, wrap: false});   
    
    jQuery('.testimonials-carousel-widget').carousel({interval: 5000, pause: "hover"});

});

