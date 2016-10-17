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
	<div class="col-12 col-desktop-8 col-tablet-8">
	<h3 class="title_right"><?php echo $heading_title; ?></h3>
		<div class="small gray"><i class="fa fa-clock-o" aria-hidden="true"></i>
<?php echo $text_post_on . ' ' .$date_added; ?> &nbsp; &nbsp; <i class="fa fa-eye" aria-hidden="true"></i> <?php echo $viewed .' '. $text_viewed; ?> </div>
		<h2 class="short-desc strong h6" itemprop="description"><?php echo $short_description; ?></h2>
		<div class="newscontent">
		  <?php echo $description; ?>
		</div>
		<div class="shareme">
	  		<span class="inline-block orange left strong h5 no-margin">Chia sẻ </span>
	    	<a href="https://twitter.com/share?url=<?php echo $url; ?>" target="_blank" class="twitter-icon inline-block" rel="nofollow">Twitter Share</a>
	    	<a href="https://plus.google.com/share?url=<?php echo $url; ?>" target="_blank" class="plus-icon inline-block" rel="nofollow">Google+ Share</a>
	    	<a href="http://facebook.com/share.php?u=<?php echo $url; ?>" target="_blank" class="face-icon inline-block" rel="nofollow">Facebook Share</a>
	    </div>
	    <div class="rowgutter">
			<?php if ($news) { ?>
		   <div class="box">
		   <h3 class="box-heading"><?php echo $tab_related; ?></h3>
		      	<?php foreach ($news as $related_news) { ?>
		      	<div class="row clear news-i">		      	
		      		<div class="col-4 no-padding thumb-i">
		      			<a href="<?php echo $related_news['href']; ?>"><img src="<?php echo $related_news['thumb']; ?>" alt="<?php echo $related_news['name']; ?>" /></a>
		      		</div>
		      		<div class="col-8">
		      			<a class="medium" href="<?php echo $related_news['href']; ?>"><?php echo $related_news['name']; ?></a>
		      			<span class="small grey block"><?php echo $related_news['date_added']; ?></span>
		      		</div>
		      	</div>
		      	<div class="linegrey"></div>    	
		      	<?php } ?>
		   </div>
		   <?php } ?>
		   <?php if ($other_news) { ?>
		   <div class="box">
		      <h3 class="box-heading"><?php echo $tab_others; ?></h3>
		      	<?php foreach ($other_news as $other_news_item) { ?>
		      	<div class="row clear news-i">
		      		<div class="col-4 no-padding thumb-i">
		      			<a href="<?php echo $other_news_item['href']; ?>"><img src="<?php echo $other_news_item['thumb']; ?>" alt="<?php echo $other_news_item['name']; ?>" /></a>
		      		</div>
		      		<div class="col-8">
		      			<a class="medium" href="<?php echo $other_news_item['href']; ?>"><?php echo $other_news_item['name']; ?></a>
		      			<span class="small gray block"><?php echo $other_news_item['date_added']; ?></span>
		      		</div>
		      	</div>
		      	<div class="linegrey"></div>
		      	<?php } ?>
		   </div>
		   <?php } ?>
		</div> 
   </div>
   <div class="col-4 show-tablet hide-mobile show-desktop">
	   	   <?php echo $column_right; ?>
   	</div>
</div>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?>