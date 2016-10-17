<?php echo $header; ?>
<div id="topcontent_sub" class="relative">
	<div class="container">
	<div class="row clear">
		<?php echo $content_top; ?>
	</div>
	</div>
</div>
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
	<div class="col-12 col-desktop-8 col-tablet-8">
	<h3 class="title_right"><?php echo $heading_title; ?></h3>
    <?php if ($news) { ?>
		<div class="media-list">
		<?php foreach ($news as $news_item) { ?>
			<div class="media row clear">
				 <div class="col-4">
					 	<a href="<?php echo $news_item['href']; ?>"><img src="<?php echo $news_item['thumb']; ?>" alt="<?php echo $news_item['name']; ?>" /></a>
				 </div>
				 <div class="col-8 col-tablet-7 col-desktop-7">
					  <h3 class="h4 name-i strong"><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['name']; ?></a></h3>
					  <div class="small gray"><i class="fa fa-clock-o" aria-hidden="true"></i>
<?php echo $text_post_on . ' ' .$news_item['date_added']; ?> &nbsp; &nbsp; <i class="fa fa-eye" aria-hidden="true"></i> <?php echo $news_item['viewed'] .' '. $text_viewed; ?> </div>
					  <div class="description medium hide-mobile show-tablet show-desktop grey"><?php echo $news_item['short_description']; ?></div>
					  <a class="round readmore-l inline-block small" href="<?php echo $news_item['href']; ?>"><i>Chi tiết</i></a> 
				  </div>
			</div>
		<?php } ?>
		</div>
		<div class="tool">
			<div class="pagination  pagination-small pagination-right">
				<?php echo $pagination; ?>
			</div>
		</div>
	<?php } ?>
	<?php if (!$news) { ?>
		<div class="content"><?php echo $text_empty; ?></div>
	<?php } ?>
	</div>
   	<div class="col-4 show-tablet hide-mobile show-desktop">	
		<?php echo $column_right; ?>
   	</div>
</div>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?>