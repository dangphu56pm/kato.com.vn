<div class="box featured">
<h3>Dịch vụ nổi bật</h3>
<div class="row clear">
  <?php foreach ($products as $product) { ?>
  		<div class="productshow col-6 col-desktop-4 col-tablet-4">
        	<div class="thumb"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /><h4 class="text-center"><?php echo $product['name']; ?><h4><span class="block medium"><?php echo $product['short_description']; ?></span></a>
        	</div>
    	</div>
  <?php } ?>
</div>
</div>