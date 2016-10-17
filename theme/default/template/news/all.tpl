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
	    <?php if ($news) { ?>
		<div class="media-list">
		<?php foreach ($news as $news_item) { ?>
			<div class="media row clear gutter">
				 <div class="col-12 col-desktop-1 col-tablet-1 no-padding">
				 	<div class="date-l round greenbg text-center white rowgutter">
				 		<span class="block h3 no-margin"><?php echo $news_item['date_day']; ?></span>
				 		<span class="block small"><?php echo $news_item['date_month'] . '.' . $news_item['date_year']; ?></span>
				 	</div>
				 	<div class="view-l text-center hide-mobile show-tablet show-desktop">
				 		<i class="fa fa-eye h1 greencolor" aria-hidden="true"></i>
				 		<br/>
				 		<?php echo $news_item['viewed']; ?>
				 	</div>
				 </div>
				 <div class="col-4">
					 	<a href="<?php echo $news_item['href']; ?>"><img src="<?php echo $news_item['thumb']; ?>" alt="<?php echo $news_item['name']; ?>" /></a>
				 </div>
				 <div class="col-8 col-tablet-7 col-desktop-7">
					  <h3 class="h4 name-i strong"><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['name']; ?></a></h3>
					  <div class="description medium hide-mobile show-tablet show-desktop grey"><?php echo $news_item['short_description']; ?></div>
					  <a class="round readmore-l inline-block uppercase small" href="<?php echo $news_item['href']; ?>">Đọc tiếp <i class="fa fa-angle-right" aria-hidden="true"></i>
</a>
				  </div>
			</div>
			<div class="linehr"></div>
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
   	<div class="col-3 show-tablet hide-mobile show-desktop">
   <?php echo $column_right; ?>
   	</div>
</div>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?>