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
     <?php echo $adv_top; ?>
</div>
</div>

<div id="body">
<div class="container zonegutter">
<div class="row clear">
  <div class="col-12 col-desktop-9 col-tablet-9">
	<?php if ($videos) { ?>
		<div class="row clear">
		<?php foreach ($videos as $key=>$video) { ?>
		<div class="col-6 col-desktop-4 col-tablet-4">
			<div class="image-wrap rowgutter">
				<a class="mediabox block relative" href="<?php echo 'https://www.youtube.com/watch?v='.$video['url']; ?>"><img src="https://img.youtube.com/vi/<?php echo $video['url']; ?>/mqdefault.jpg" alt="<?php echo $video['title']; ?>" class="block" />
					<div class="play-i absolute text-center white hide">
						<div class="before"></div>
						<span>	
							<i class="fa fa-play-circle-o" aria-hidden="true"></i>
							<em class="videodate small"><?php echo date($this->language->get('date_format_short'), strtotime($video['date_add'])); ?></em>
						</span>
					</div>
				</a>
				<h3 class="h6 videoname grey"><a href="gallery/video&video_id=<?php echo $video['video_id']; ?>"><?php echo $video['title']; ?></a></h3>
		  </div>
		</div>
		<?php } ?>
		</div>
		<div class="tool col-gutter <?php echo $video_total<12 ? 'none':''; ?>">
			<div class="pagination  pagination-small pagination-right">
				<?php echo $pagination; ?>
			</div>
		</div>
	<?php } ?>
	<?php if (!$videos) { ?>
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