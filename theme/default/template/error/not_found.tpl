<?php echo $header; ?>
<div class="wrapper container">
<div class="row clear no-margin">
<div class="col-12 col-desktop-9 col-tablet-9">
	<div class="breadcrumb small">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
		<h1><?php echo $heading_title; ?></h1>
		<?php echo $text_error; ?>

  </div>
  <?php echo $column_right; ?>
</div>
 <?php echo $content_bottom; ?>
 </div>
<?php echo $footer; ?>