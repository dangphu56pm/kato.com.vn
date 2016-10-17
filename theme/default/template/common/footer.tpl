<div id="footer" class="bluebg relative">
<div class="container">
<div class="row clear white">
	<div class="col-12 col-desktop-6 col-tablet-6">
		<h2 class="uppercase strong no-margin h6 absolute configname redbg"><?php echo $config_name; ?></h2>
		<span class="address" aria-hidden="true">&nbsp; &nbsp;Địa chỉ: <?php echo $address; ?></span><br />
	    <span class="tel" aria-hidden="true">&nbsp; Tel: <?php echo $telephone; ?></span><br />
	    <span class="fax" aria-hidden="true">&nbsp; Fax: <?php echo $fax; ?></span><br />
	    <span class="mail" aria-hidden="true">&nbsp; Email: <a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></span><br />
		<p class="small">&copy; <?php echo date('Y');?> World Courier Express Vietnam., JSC</p>
		<br /><a class="small gray" title="thiet ke web dep tai Ha Noi" href="http://osd.vn" target="_blank">Thiết kế web OSD.VN</a>
	</div>
	
	<?php echo $footer_menu; ?>
	
	<?php echo $bottom; ?>
</div>
</div>
</div>
<?php foreach ($scripts as $script) { ?>
	<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<script type="text/javascript" src="static/js.js"></script>
<script type="text/javascript" src="static/swiper.min.js"></script>
<script>
var scrollswiper = new Swiper('.carousel-autoplay', {
    slidesPerView: 3,
    paginationClickable: true,
    nextButton: '.pnext',
    prevButton: '.pprev',
    loop:true,
     breakpoints: {
            768: {
                slidesPerView: 1
            },
            640: {
                slidesPerView:1
            },
            320: {
                slidesPerView: 1
            }
        }
});
var scrollswiper1 = new Swiper('.carousel-autoplay2', {
    slidesPerView: 2,
    paginationClickable: true,
    nextButton: '.nnext',
    prevButton: '.nprev',
    loop:true,
     breakpoints: {
            768: {
                slidesPerView: 1
            },
            640: {
                slidesPerView:1
            },
            320: {
                slidesPerView: 1
            }
        }
});
</script>
<script>var opts = {auto:{speed:3500,pauseOnHover:true},fullScreen:false,swipe:false};
makeBSS('.num1', opts);
</script>
<?php if ($config_local==1) { ?>
<div><div class="hide" itemscope itemtype="<?php echo $type_seo; ?>">
<span itemprop="name"><?php echo $name_seo; ?></span>
<div itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
<span itemprop="streetAddress"><?php echo $street_seo; ?></span>, 
<span itemprop="addressLocality"><?php echo $locality_seo; ?></span>, 
<span itemprop="addressRegion"><?php echo $region_seo; ?></span>, 
<span itemprop="postalCode"><?php echo $postalcode_seo; ?></span>
</div></div>
<?php } else {?>
<?php } ?>
<?php echo $google_analytics; ?>
<?php echo $google_remark; ?>
</body></html>