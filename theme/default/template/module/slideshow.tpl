<div class="bss-slides num1" tabindex="1">
    <?php foreach ($banners as $banner) { ?>
    <?php if ($banner['link']) { ?>
	    <figure>
			<a href="<?php echo $banner['link']; ?>">
				<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
				<div class="container"><div class="row clear no-margin"><div class="absolute name-slide white"><h3 class="text-slide title">World courier  - express Vietnam</h3><span><?php echo $banner['title']; ?></span></div></div></div>
			</a>
		</figure>
    <?php } else { ?>
    	<figure><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /><div class="container"><div class="row clear no-margin"><div class="absolute name-slide"><?php echo $banner['title']; ?></div></div></div></figure>
    <?php } ?>
    <?php } ?>
</div>