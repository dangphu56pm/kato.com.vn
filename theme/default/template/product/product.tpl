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
	        <div class="col-12 col-desktop-9 col-tablet-9">
            
            <?php if ($images) { ?>
                <div class="image-additional">
                    <?php foreach ($images as $image) { ?>
                        <a href="<?php echo $url; ?>"><img src="<?php echo $image['thumb']; ?>" alt="<?php echo $heading_title; ?>" /></a>
                    <?php } ?>
                </div>
            <?php } ?>
            <div class="row clear">
                <div class="col-12">
                    <h2 class="short_desc h4">
                        <?php echo $short_description; ?>
                    </h2>
                    <div class="description2">
	                    <?php echo $description; ?>
                    </div>
                    <br />
                    <div class="hotlinein">Gọi <strong><?php echo $hotline2; ?></strong> để được tư vấn</div>
                    <br />
                    <div class="shareme">
                        <a href="https://twitter.com/share?url=<?php echo $url; ?>" target="_blank" class="twitter-icon inline-block" rel="nofollow">Twitter Share</a>
                        <a href="https://plus.google.com/share?url=<?php echo $url; ?>" target="_blank" class="plus-icon inline-block" rel="nofollow">Google+ Share</a>
                        <a href="http://facebook.com/share.php?u=<?php echo $url; ?>" target="_blank" class="face-icon inline-block" rel="nofollow">Facebook Share</a>
                    </div>
                	<div class="rowgutter">
						<?php echo $column_left; ?>  
					</div>    
                </div>

                <div class="col-12">
<?php if (isset($news_relateds)) { ?>	
    <?php if ($news_relateds) { ?>
                            <div class="box">
                                <div class="othernews">
                                    <h3>Bài viết liên quan</h3>	 
                                    <ul> 
                                        <?php foreach ($news_relateds as $news_item) { ?>
                                            <li><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['name']; ?></a></li>
        <?php } ?>
                                    </ul>
                                </div>
                            </div>
                        <?php } ?>
                    <?php } ?>

<?php if ($products) { ?>
                        <div class="box">
                            <h2 class="heading uppercase"><?php echo $tab_related; ?></h2>
                            <div class="row clear no-margin">
                                    <?php foreach ($products as $product) { ?>
                                    <div class="col-6 col-desktop-4 col-tablet-4 products">
                                            <?php if ($product['thumb']) { ?>
                                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                            <h3 class="h4 strong"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
                                    <?php } ?>
                                    </div>
                        <?php } ?>
                            </div>
                        </div>
<?php } ?>
                </div>
            </div>
        </div>
        <div class="col-3 show-tablet hide-mobile show-desktop">
        	<?php echo $column_right; ?>
        </div>
    </div>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?>