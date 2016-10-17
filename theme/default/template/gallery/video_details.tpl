<?php echo $header; ?>
<div id="subheader">
<div class="container rowgutter relative">
	<div class="small breadcrumbs" xmlns:v="http://rdf.data-vocabulary.org/#">
            <span itemprop="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="v:url" property="v:title"><?php echo $breadcrumb['text']; ?></a>
                <?php } ?>
            </span>
     </div>  
     <h1 class="h3"><?php echo $heading_title; ?></h1>
</div>
</div>

<div id="body">
<div class="container zonegutter">
<div class="row clear">
  <div class="col-12 col-desktop-9 col-tablet-9">
		<div id="videoframe">
			<iframe width="650" height="400"
				src="https://www.youtube.com/embed/<?php echo $url; ?>">
			</iframe>
		</div>
		<div class="videodesc">
			<h3 class="h5 strong"><?php echo $heading_title; ?></h3>
			<div class="small gray"><i class="fa fa-clock-o" aria-hidden="true"></i>
 <?php echo $date_add; ?></div>
 			<div class="medium">
				<?php echo $description; ?>
 			</div>
		</div>
		<div class="rowgutter">
			 <?php echo $column_left; ?>
		</div>
  </div>
  <div class="col-3 show-desktop show-tablet hide-mobile">
	<?php echo $column_right; ?>
  </div>
</div>

<?php echo $content_bottom; ?>

</div>
</div>
<?php echo $footer; ?>