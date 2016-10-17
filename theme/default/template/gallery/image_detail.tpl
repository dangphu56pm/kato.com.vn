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
     <?php echo $avd_top; ?>
</div>
</div>
<div id="body">
<div class="container gallery-detail zonegutter">
<div class="row clear">
  <div class="col-12 col-tablet-9 col-desktop-9">	
	<?php if ($images) { ?>	
		<div class="row clear">
		<div class="baguetteBox">
		<?php foreach ($images as $key=>$image) { ?>
		<div class="col-6 col-desktop-4 col-tablet-4">
			  <a href="<?php echo $image['full']; ?>" data-caption="<?php echo $image['name']; ?>" class="block photo relative">
			  	<img src="<?php echo $image['thumb']; ?>" data-caption="<?php echo $image['name']; ?>" class="lightbox-photo block"/>
			  	<div class="absolute photo-cover hide">
			  		<i class="fa fa-search-plus white" aria-hidden="true"></i>
			  	</div>
			  	</a>
			  <h3 class="h6 strong grey"><?php echo $image['name']; ?></h3>
		</div>
		<?php } ?>
		</div>
		</div>
		<?php echo $content_bottom; ?>		
	<?php } ?>
	<?php if (!$images) { ?>
		<div class="content"><?php echo $text_empty; ?></div>
	<?php } ?>
	</div>
	<div class="col-3 show-tablet hide-mobile show-desktop">
		<?php echo $column_right; ?>
	</div>
</div>
</div>
</div>
<?php echo $footer; ?>