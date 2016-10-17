<?php if($position == 'content_top'){ ?>
<div class="row clear rowgutter">
  <?php foreach ($products as $product) { ?>
  		<div class="col-1-5 productshow">
		<?php if ($product['thumb']) { ?>
			<a class="block text-center" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
		<?php } ?>
		<span class="block text-center sevice"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></span>
		</div>
<?php } ?>
</div>
<?php }else{ ?>
<h3 class="title strong">Dịch vụ Vận chuyển - Chuyển phát</h3>
<div class="row clear">
<div class="box col-12 rowgutter">
<div class="swiper-container carousel-autoplay">
<div class="swiper-wrapper">
  <?php foreach ($products as $product) { ?>
  		<div class="productshow white">
		<?php if ($product['thumb']) { ?>
			<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
		<?php } ?>
		<div class="desc">
		<h3 class="name"><a href="<?php echo $product['href']; ?>" class="white"><?php echo $product['name']; ?></a></h3>
		<span><?php echo $product['description']; ?></h3>
		</div>
		</div>
<?php } ?>
</div>

</div>
<div class="swiper-next pnext"></div>
<div class="swiper-prev pprev"></div>
</div>

</div>
<?php } ?>