<div class="box">
<h3 class="box-heading"><?php echo $heading_title; ?></h3>
<ul class="list-unstyled list-menu">
  <?php foreach ($informations as $information) { ?>
  		<li><a href="<?php echo $information['href']; ?>"><i class="fa fa-arrow-circle-right" aria-hidden="true"></i>
 <?php echo $information['title']; ?></a></li>
  <?php } ?>
</ul>
</div>