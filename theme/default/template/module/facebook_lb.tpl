<div class="box">
<div class="fb-page" data-href="<?php echo $page_url; ?>" data-tabs="timeline" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-height="<?php echo $height; ?>" data-show-facepile="true"><blockquote cite="<?php echo $page_url; ?>" class="fb-xfbml-parse-ignore"><a href="<?php echo $page_url; ?>">Facebook Fanpage</a></blockquote></div>
</div>	

<div id="fb-root"></div>
<script>
		window.fbAsyncInit = function() {
			FB.init({
				<?php if ($flb_app_id) { ?>
				appId      : '<?php echo $flb_app_id; ?>', // App ID
				<?php } ?>
				status     : true,
				cookie     : true, 
				xfbml      : true 
			});
			
			
		};

		// Load the SDK Asynchronously
		(function(d){
			var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
			js = d.createElement('script'); js.id = id; js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			d.getElementsByTagName('head')[0].appendChild(js);
		}(document));
</script>