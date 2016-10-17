<div class="col-12 col-desktop-4 col-tablet-4 rowgutter">
<a href="gallery/video" class="block"><img src="static/video-img.jpg" alt="<?php echo $heading_title; ?>" /></a>
	<h3 class="h5 strong uppercase catname">
		<a href="gallery/video">
			<i class="fa fa-video-camera" aria-hidden="true"></i>
			<?php echo $heading_title; ?>
		</a>
	</h3>
    <ul class="squarelist list-unstyled">
      <?php foreach ($videos as $video) { ?>
      <?php if($video['video_id'] > 0 ){ ?>
        <li><a class="grey block" href="<?php echo $video['href']; ?>"><i class="fa fa-caret-right" aria-hidden="true"></i>
        <?php echo $video['title']; ?></a></li>
      <?php } ?>
      <?php } ?>
  </ul>
</div>  