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
<div class="container zonegutter">
<div class="row clear">
  <div class="col-12 col-tablet-9 col-desktop-9">
	<?php if ($images) { ?>
		<div class="row clear">
		<?php foreach ($images as $key=>$image) { ?>
		<div class="col-6 col-desktop-4 col-tablet-4">
			<div class="image-wrap album rowgutter">
				  <a href="<?php echo $image['href']; ?>" class="block relative">
				  	<img src="<?php echo $image['thumb']; ?>" alt="<?php echo $image['name']; ?>" class="block" />
				  	<div class="play-i absolute text-center white hide">
						<div class="before"></div>
						<span><i class="fa fa-external-link" aria-hidden="true"></i></span>
					</div>
				  	
				  </a>
				  <h3 class="h6 videoname gray"><a href="<?php echo $image['href']; ?>"><?php echo $image['name']; ?></a></h3>
		  	</div>
		</div>
		<?php } ?>
		</div>
		<div class="tool col-gutter <?php echo $images_total<12 ? 'none':''; ?>">
			<div class="pagination  pagination-small pagination-right">
				<?php echo $pagination; ?>
			</div>
		</div>
		<?php echo $content_bottom; ?>		
	<?php } ?>
	<?php if (!$images) { ?>
	
	<?php } ?>
</div>
	<div class="col-3 show-tablet hide-mobile show-desktop">
		<?php echo $column_right; ?>
	</div>
</div>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?>