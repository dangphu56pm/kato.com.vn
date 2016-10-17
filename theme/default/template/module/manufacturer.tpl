<div class="box manufacturer">
  <div class="box-heading"><p>Thương hiệu</p></div>
  <div class="box-content">
    <?php if ($manufacturers) { ?>
    <ul class="box-manufacturer">
		<?php foreach ($manufacturers as $manufacturer) { ?>
			<li>
            	<a href="<?php echo $manufacturer['href']; ?>" target="_blank" title="<?php echo $manufacturer['name']; ?>">
                	<?php echo $manufacturer['name']; ?>
                </a>
            </li>
		<?php } ?>
	</ul>
    <?php } ?>
  </div>
</div>